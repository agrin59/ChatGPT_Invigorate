# ChatGPT Invigorate

A practical toolkit to increase ChatGPT Enterprise adoption among non-technical professionals who are skeptical, intimidated, or constrained by prior bad experiences.

## Project Context
All work in this repo aims to build trust, show quick wins, and use plain language. See `AGENTS.md` for agent roles (CA, EA, MA, USA, EPA, CRA, RA) and structured output schemas.

## Quick Start
- Research CLI (local search):
  - `powershell -ExecutionPolicy Bypass -File scripts/research.ps1 -Query "security policy" -IncludeContentSnippets -MaxResults 20`
  - Install YAML support if needed:
    - `Install-Module powershell-yaml -Scope CurrentUser; Import-Module powershell-yaml`
    - or use PowerShell 7+: `winget install Microsoft.PowerShell` then run `pwsh`
- Config: edit `config/research.yaml` to adjust paths, file types, and per-profile defaults.

## Repository Structure
- `AGENTS.md` agent guidelines and output schemas
- `config/research.yaml` Research Agent config (approved local paths)
- `scripts/research.ps1` PowerShell search CLI returning JSON
- `docs/` working notes and TODOs

## Contributing
- Follow `AGENTS.md` for coding style, testing, and PR conventions.
- Keep changes small, documented, and focused on skeptical non-technical users.
- Use Conventional Commits (e.g., `feat:`, `fix:`, `docs:`).

## CI
- GitHub Actions runs a lightweight check on push/PR to validate the repository and execute the research CLI against the repo contents.

## License
TBD by repository owner.