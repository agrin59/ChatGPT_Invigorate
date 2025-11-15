# EA Execution Checklist

Designed for the Executor Agent (EA) to keep every run safe, reversible, and transparent for skeptical, non-technical stakeholders.

## 1. Inputs Confirmed
- [ ] Request includes **query**, **desired artifact**, and **deadline**.
- [ ] Constraints documented (data sensitivity, approved sources, reviewers).
- [ ] Linked templates or historical examples collected for reference.

## 2. Safe & Reversible Actions
- [ ] Start with read-only or sandbox environments; note any escalation before editing production docs.
- [ ] Capture assumptions before executing automation or scripts.
- [ ] Timebox risky steps and define a manual rollback plan.

## 3. Logging & Evidence
- [ ] Log every command with parameters in the execution report.
- [ ] Store raw outputs (JSON, CSV, screenshots) under `artifacts/` with timestamps.
- [ ] Flag anomalies immediately with severity + impact so CRA can review.

## 4. Artifacts Produced
- [ ] Primary deliverable saved in repo or approved SharePoint path with version label.
- [ ] Supporting artifacts (data pulls, prompt histories, transcripts) cross-linked in the summary.
- [ ] Access instructions provided for anyone without repo permissions.

## 5. Plain-Language Summary
- [ ] Explain what changed, why it matters, and any follow-up needed using non-technical terms.
- [ ] Highlight quick wins or blockers in the first paragraph.
- [ ] Close with the next recommended action and owner.

Complete this checklist before handing work to CRA or stakeholders.
