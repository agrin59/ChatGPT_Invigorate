POWERSHELL := $(shell command -v pwsh || command -v powershell || command -v powershell.exe)
QUERY ?= adoption quick wins
MAX_RESULTS ?= 5

.PHONY: setup lint test run

setup:
	@if [ -z "$(POWERSHELL)" ]; then \
		echo "PowerShell not found. Install PowerShell 7+ (pwsh) or enable Windows PowerShell with the powershell-yaml module."; \
	else \
		echo "Using PowerShell at $(POWERSHELL)."; \
	fi
	@echo "Optional: add paths to config/research.yaml (or research.json) before running queries."

lint:
	@if [ -z "$(POWERSHELL)" ]; then \
		echo "PowerShell is required to lint the CLI script."; \
		exit 1; \
	fi
	@"$(POWERSHELL)" -NoLogo -NoProfile -Command "if (Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue) { Write-Host 'YAML parser detected.' } else { Write-Warning 'powershell-yaml missing; JSON fallback will be used.' }"

test:
	@if [ -z "$(POWERSHELL)" ]; then \
		echo "PowerShell is required to run tests."; \
		exit 1; \
	fi
	@"$(POWERSHELL)" -ExecutionPolicy Bypass -File scripts/research.ps1 -Query "$(QUERY)" -MaxResults 1 | Out-Null
	@echo "Smoke test complete (MaxResults=1)."

run:
	@if [ -z "$(POWERSHELL)" ]; then \
		echo "PowerShell is required to run the research CLI."; \
		exit 1; \
	fi
	@"$(POWERSHELL)" -ExecutionPolicy Bypass -File scripts/research.ps1 -Query "$(QUERY)" -MaxResults $(MAX_RESULTS) -IncludeContentSnippets
