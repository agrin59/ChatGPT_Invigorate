# Next Session TODOs

- [x] CRA rubric: Create `docs/rubric.json` with categories (factual_accuracy, tone_alignment, clarity, actionability, risk), weights, and pass thresholds.
- [x] EA checklist: Add `docs/execution_checklist.md` covering inputs, safe/reversible actions, logs, artifacts, and plain-language summaries.
- [x] MA templates: Add email + intranet copy templates aligned to objections (security, reliability, ease of use) and CTAs.
- [x] EPA RACI: Add `docs/event_raci.md` with roles (EA, EPA, CRA, Security, Facilities) and responsibilities.
- [x] RA queries: Add `docs/research_queries.md` with example queries per agent and expected outputs.
- [x] Research config fallback: Optional `config/research.json` and script fallback if YAML module is unavailable.
- [x] Makefile/scripts: Add convenience targets (setup, lint, test, run) or PowerShell equivalents.
- [ ] Validation: Light pass to ensure `AGENTS.md` examples stay under 400 words and reflect non-technical audience needs.

Notes
- Research CLI requires either PowerShell 7+ (preferred) or the `powershell-yaml` module for YAML parsing.
- JSON fallback keeps the CLI usable if the YAML parser cannot load.
