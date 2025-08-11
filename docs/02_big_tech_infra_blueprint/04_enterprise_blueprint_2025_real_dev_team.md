# Enterprise Product Development Blueprint — State of the Art (Aug 2025)

> Concise, phase‑gated blueprint that integrates security, reliability, AI governance, UX/accessibility, and FinOps from day one.

## Phase 0 — Product Strategy & Discovery (1–3 wks)
**Goals:** Validate problem/solution fit and set measurable outcomes.
- Product vision, target users, and **North Star Metric** with supporting KPIs/OKRs.
- User/market research, competitor mapping, JTBD and top jobs/pain points.
- Regulatory scan & constraints (e.g., sector rules, GDPR, **EU AI Act** scope if AI), initial **DPIA pre‑check**.
- Accessibility goals at WCAG 2.2 AA; localization/internationalization scope.
- Initial risk log & assumptions; success/failure thresholds.
- Exec one‑pager and **decision narrative**.

**Gate G0:** Problem, users, and outcomes are clear; exec sponsor signs the one‑pager.

---

## Phase 1 — Feasibility & Architecture (1–2 wks)
**Goals:** Establish a viable, cost‑aware solution approach.
- Context diagram and **high‑level architecture**; map to a cloud Well‑Architected framework.
- Non‑functional requirements: reliability, performance, security, privacy, scalability, cost targets.
- Build‑vs‑buy, vendor/DPA & licensing review; data classification & retention policy.
- **Threat modeling** (STRIDE/LINDDUN) and privacy-by-design requirements.
- Tech stack shortlist with version & EoL review; repo strategy (mono/poly), coding standards.
- Initial **FinOps** estimate (run‑rate, burst costs, AI/compute projections).

**Gate G1:** Architecture & NFRs approved; high risks, costs, and compliance impacts understood.

---

## Phase 2 — Governance & Engineering Controls Setup (1–2 wks, parallelizable)
**Goals:** Put guardrails in place before writing lots of code.
- **Secure SDLC (NIST SSDF)** policies: code review, secrets mgmt, SAST/DAST, dep scanning, vulns SLAs.
- **Supply chain**: SBOM (SPDX/CycloneDX), provenance & **SLSA** level target, **Sigstore/Cosign** signing, OpenSSF **Scorecard** in CI.
- **CI/CD**: trunk‑based dev, pre‑commit hooks, gated merges, artifact repository, environment strategy.
- **Release safety**: feature flags, canary/blue‑green, progressive delivery with automated rollback.
- **Observability baseline**: OpenTelemetry (traces, metrics, logs), golden signals, dashboards.
- **SRE readiness**: SLOs, **error budgets**, on‑call rota, incident runbooks & postmortem template.
- **Data governance**: DPO touchpoint, DPIA plan, retention & deletion, data import/export rules.
- **AI governance (if applicable)**: ISO/IEC 42001 alignment; model/data lineage, eval harness, red teaming, model/prompt cards, safety guardrails.
- **Security requirements** mapped to **OWASP ASVS**, privacy to DPIA controls; access control model (RBAC/ABAC).
- **Docs & decisions**: RFC/ADR repository, architecture decision log.

**Gate G2:** CI/CD green, security & supply‑chain controls enforced, SLOs & runbooks in place.

---

## Phase 3 — Detailed Design & Test Strategy (1–2 wks)
**Goals:** Remove ambiguity before implementation.
- System design docs & **RFCs**; API contracts with versioning; schema & migration plan.
- UX flows, content strategy, and design‑system tokens; accessibility acceptance criteria.
- **Test strategy**: unit/integration/E2E pyramid, contract tests, performance budgets, chaos tests.
- **Experimentation plan**: flags, rollout cohorts, A/B metrics and guardrails.
- **Performance & scalability** modeling; capacity plan and caching strategy.

**Gate G3:** RFCs approved; test/acceptance criteria and performance budgets signed off.

---

## Phase 4 — Delivery Planning (≤1 wk)
**Goals:** Create a realistic, measurable plan.
- Milestones, epics, and story map; DRI ownership & RACI.
- Critical path & dependencies; risk register with triggers & mitigations.
- Release plan (environments, change windows, comms, rollback) and training plan.

**Gate G4:** Plan is feasible; resources allocated; cut scope if needed to protect quality.

---

## Phase 5 — Build & Integrate (iterative sprints)
**Goals:** Ship small, safe, observable increments.
- Trunk‑based dev; small PRs; pair/mob for complex areas.
- Automated tests as gates; ephemeral preview envs per PR.
- Generate SBOMs per build; sign artifacts; provenance attestation.
- OTel instrumentation in code; dashboards auto‑provisioned.
- Continuous security: dep updates, license checks, infra as code scans.
- **AI workstream** (if used): dataset governance, evals, bias/fairness checks, jailbreak/resilience tests.
- Continuous product demos with user feedback.

**Gate G5 (per increment):** All checks green; release notes & runbooks updated.

---

## Phase 6 — Pre‑Launch Readiness (hardening)
**Goals:** Prove it’s safe to roll out.
- Performance/load tests vs budgets; disaster/chaos game‑day.
- Security pen‑test & remediation; compliance sign‑offs; DPIA completed.
- Accessibility audit (WCAG 2.2 AA); i18n/l10n checks; content & support docs.
- DR/BCP validated; cost burn forecast; monitoring/alert run review.

**Gate G6:** Go/No‑Go with sign‑offs from Product, Security/Privacy, SRE, Support.

---

## Phase 7 — Launch & Rollout
**Goals:** Release with control & insight.
- Progressive delivery (canary → % rollout → full) via feature flags.
- Live SLO & error‑budget monitoring; automated rollback thresholds.
- War‑room playbook; customer comms; incident handling.

**Gate G7:** Rollout health meets SLOs; no critical regressions.

---

## Phase 8 — Operate, Learn & Scale (continuous)
**Goals:** Improve reliability, speed, and economics.
- Postmortems (blameless) and action item SLAs; weekly error‑budget review.
- DORA metrics (deploy freq, lead time, MTTR, change fail rate) tracked and published.
- FinOps cycle (Inform → Optimize → Operate); rightsizing & savings plans; AI/compute cost controls.
- Experimentation & growth loops; roadmap refresh; knowledge transfer.
- Periodic security & privacy reviews; supply‑chain posture and SBOM refresh.

---

## Core Artifacts (living)
- One‑pager, OKRs, NSM; Risk register; Data map & DPIA.
- Architecture diagrams, RFCs, ADRs; API specs; schema & migrations.
- Test plan & coverage dashboard; perf/chaos results.
- SLOs/error‑budget policy; runbooks; incident/postmortem templates.
- CI/CD config; SBOMs; provenance attestations; release & rollback runbooks.
- UX flows, content, DS tokens; accessibility checklist & audit report.
- Cost model & FinOps reports; launch/rollout plan; training/support docs.

---

### Quality Gates (summary)
G0 Discovery ✓  G1 Feasibility ✓  G2 Controls ✓  G3 Design ✓  G4 Plan ✓  
G5 Increment ✓  G6 Launch‑readiness ✓  G7 Rollout health ✓  (then continuous Opex)

