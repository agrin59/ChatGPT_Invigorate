# Executor Agent (EA) – Execution Checklist

Use this checklist for each stage from the CA plan. Keep actions safe, reversible, and easy to understand for non-technical stakeholders.

## Inputs & Validation
- [ ] Stage ID and objective confirmed
- [ ] Tools and parameters listed (from CA plan)
- [ ] Data sensitivity reviewed; no secrets/PII in samples
- [ ] Prerequisites checked (access, paths, config)

## Plan & Safety
- [ ] Dry-run available or sandbox first
- [ ] Rollback plan defined and documented
- [ ] Changes are incremental and reversible

## Execution
- [ ] Log each step with command/inputs/duration
- [ ] Capture issues + mitigations inline
- [ ] Store artifacts with stable IDs and paths

## Artifacts
- [ ] Logs (text) and summaries generated
- [ ] Outputs named `artifacts/<stage>/...`
- [ ] Attach evidence links for CRA review

## Stakeholder Summary (Plain Language)
- [ ] What we did (1–2 lines)
- [ ] Why it matters (business outcome)
- [ ] Risks/limitations and how we mitigated them
- [ ] Next actions and owners

## Handoffs & Reviews
- [ ] Submit to CRA with rubric reference
- [ ] Notify MA/USA/EPA if inputs needed
- [ ] Update CA on status/blockers

## Close-Out
- [ ] Update AGENTS.md or docs if behavior changed
- [ ] File paths and parameters recorded for reuse
- [ ] Back out temporary settings; clean up

Tip: Produce an Execution Report JSON per AGENTS.md (EA schema) for consistent, parsable outputs.