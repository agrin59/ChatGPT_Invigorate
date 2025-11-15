# Research Agent Query Examples

Pair each query with the `-Profile` flag so the Research Agent emphasizes the right sources and ranking boosts.

| Agent | Example Queries | Expected Output Notes |
| --- | --- | --- |
| CA | "30-day adoption strategy" / "Skeptical exec KPI" | Mix of roadmap docs + KPIs with citation-heavy summaries and planning milestones. |
| EA | "rollback plan template" / "safe automation checklist" | Step-by-step runbooks, checklists, and command logs to plug into the EA execution report. |
| MA | "security objection email" / "pilot invite intranet" | Messaging snippets, CTA ideas, and CRA-approved phrasing for non-technical staff. |
| USA | "101 training module" / "prompt exercise worksheet" | Lesson outlines, exercises, and reflection questions with plain-language definitions. |
| EPA | "onsite kickoff logistics" / "event budget tracker" | Venue checklists, catering specs, and RACI tables to keep planning auditable. |
| CRA | "tone rubric" / "compliance checklist" | Rubrics, reviewer notes, and escalation paths with scoring guidance. |
| RA | "finance adoption win" / "privacy FAQ" | Broad search to pull recent case studies, FAQs, and policy snippets for synthesis. |

**Tips**
1. Use `-IncludeContentSnippets` when the stakeholder expects verbatim references.
2. Combine `-PathsOverride` with a temporary SharePoint sync folder to limit scope for audits.
3. When YAML parsing fails, drop a JSON config next to `config/research.yaml` so the CLI can keep running (see README).
