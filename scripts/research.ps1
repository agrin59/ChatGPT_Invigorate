param(
  [Parameter(Mandatory = $true)][string]$Query,
  [string]$Profile = 'RA',
  [int]$MaxResults = 20,
  [string[]]$PathsOverride,
  [string[]]$FileTypes,
  [datetime]$DateFrom,
  [switch]$IncludeContentSnippets
)

$ErrorActionPreference = 'SilentlyContinue'

function Load-Yaml {
  param([string]$Path)
  if (Get-Command -Name ConvertFrom-Yaml -ErrorAction SilentlyContinue) {
    return (Get-Content -Raw -LiteralPath $Path | ConvertFrom-Yaml)
  } else {
    return $null
  }
}

function Is-TextExtension {
  param([string]$Ext)
  $t = $Ext.TrimStart('.').ToLower()
  return @('md','markdown','txt','csv','json','ps1','py').Contains($t)
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$configPath = Join-Path $repoRoot 'config/research.yaml'
$cfg = Load-Yaml -Path $configPath

if (-not $cfg) {
  Write-Warning 'ConvertFrom-Yaml is not available. Attempting minimal defaults.'
}

$indexPaths = @()
if ($cfg -and $cfg.index.paths) { $indexPaths = @($cfg.index.paths) } 
if (-not $indexPaths -or $indexPaths.Count -eq 0) {
  $indexPaths = @($repoRoot)
}

$profileNode = $null
if ($cfg -and $cfg.profiles) { $profileNode = $cfg.profiles.$Profile }

$paths = if ($PathsOverride) { $PathsOverride } elseif ($profileNode -and $profileNode.paths -and $profileNode.paths.Count -gt 0) { @($profileNode.paths) } else { $indexPaths }
$paths = $paths | Where-Object { $_ -and (Test-Path $_) }

if (-not $paths -or $paths.Count -eq 0) {
  Write-Error 'No valid search paths found. Update config/research.yaml or use -PathsOverride.'
  exit 2
}

$exts = if ($FileTypes) { $FileTypes } elseif ($profileNode -and $profileNode.filetypes) { @($profileNode.filetypes) } elseif ($cfg -and $cfg.index.filetypes) { @($cfg.index.filetypes) } else { @('md','txt','pdf','docx','pptx','xlsx','csv','json') }
$exts = $exts | ForEach-Object { $_.ToLower().TrimStart('.') } | Select-Object -Unique

$now = Get-Date
$results = @()

foreach ($p in $paths) {
  try {
    $files = Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue
    foreach ($f in $files) {
      $ext = $f.Extension.TrimStart('.').ToLower()
      if (-not ($exts -contains $ext)) { continue }
      if ($DateFrom -and ($f.LastWriteTime -lt $DateFrom)) { continue }

      $score = 0.0
      $matches = @()
      if ($f.BaseName -match [Regex]::Escape($Query)) { $score += 0.6 }

      if (Is-TextExtension -Ext $ext) {
        try {
          if ($IncludeContentSnippets) {
            $hitLines = Select-String -LiteralPath $f.FullName -Pattern $Query -SimpleMatch -Encoding UTF8 -ErrorAction SilentlyContinue
          } else {
            $hitLines = Select-String -LiteralPath $f.FullName -Pattern $Query -SimpleMatch -List -Encoding UTF8 -ErrorAction SilentlyContinue
          }
          if ($hitLines) {
            $score += [Math]::Min(0.4, ($hitLines.Count * 0.1))
            $matches = @()
            foreach ($h in $hitLines | Select-Object -First 3) {
              $matches += ([PSCustomObject]@{ line = $h.Line.Trim(); line_number = $h.LineNumber })
            }
          }
        } catch {}
      }

      # recency boost
      $ageDays = [Math]::Max(1, ($now - $f.LastWriteTime).TotalDays)
      $score += [Math]::Min(0.2, 5.0 / $ageDays)

      if ($score -gt 0) {
        $results += [PSCustomObject]@{
          path    = $f.FullName
          title   = $f.BaseName
          matches = $matches
          score   = [Math]::Round($score, 3)
          modified= $f.LastWriteTime
        }
      }
    }
  } catch {}
}

$sorted = $results | Sort-Object -Property @{Expression='score';Descending=$true}, @{Expression='modified';Descending=$true} | Select-Object -First $MaxResults

$constraints = [PSCustomObject]@{
  paths      = $paths
  filetypes  = $exts
  date_from  = if ($DateFrom) { $DateFrom.ToString('yyyy-MM-dd') } else { $null }
}

$citations = @()
foreach ($r in $sorted) {
  if ($r.matches -and $r.matches.Count -gt 0) {
    $citations += ("{0}:#L{1}" -f $r.path, $r.matches[0].line_number)
  } else {
    $citations += $r.path
  }
}

$summary = if ($sorted.Count -gt 0) { "Found $($sorted.Count) items across $($paths.Count) path(s)." } else { "No matches found." }

$out = [PSCustomObject]@{
  schema     = '1.0'
  query      = $Query
  constraints= $constraints
  results    = $sorted
  summary    = $summary
  citations  = $citations
  gaps       = @()
}

$out | ConvertTo-Json -Depth 6

