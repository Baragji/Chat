# enterprise_blueprint_2025_v3.md
**Tailored for: Solo non‑coder founder + AI dev team**  
**Phase Structure:** **−1 → 0 → 1** (mirrors your plan)  
**Timestamp:** 2025-08-11 12:58 UTC

> **Origin & Rationale.** After **five failed AI projects**, plus months of **multi‑AI consensus research**, this blueprint adopts a **zero‑trust validation** approach: *nothing ships unless independent agents agree and hard evidence proves it.* Evidence = tests pass; **SBOM + provenance** verified; **signatures** verified; **OTLP traces** present; **SLOs** healthy; **WCAG 2.2** checks pass; **budget forecast ≤ policy**.

---

## A) Business Context (front‑matter, non‑negotiable)
- **10 Business Rules (canonical):**
  1) Zero deception in AI‑generated code. 2) Production‑first standards with mandatory gates.
  3) **Full autonomy** (no manual intervention in normal flow). 4) **Per‑project cap: $150**.
  5) **Time cap: 8h execution** per project. 6) **Quality ≥ 85% composite**.
  7) Data‑safety protocols enforced. 8) Environment consistency required.
  9) Automated shutoff on violations. 10) **Real‑time cost tracking** with budget enforcement.
- **Revenue Model Targets:** **$50/successful project**; **$200/mo subscription**; **$2000/mo enterprise**; **70% gross margin**.
- **Delivery KPIs:** DORA Four Keys; SLOs for latency/availability; Accessiblity (WCAG 2.2 AA) pass rate.
- **Budget Policy:** **$300 weekly target**, **$500 hard ceiling** (FinOps FOCUS data). Release blocks on forecast breach.
- **Success Probability Target:** **≥78%** project success via *multi‑model consensus + adversarial validation* (your Phase −1 findings).

---

## B) Operating Model — **Adversarial Consensus, AI‑First, Human‑Led**
**Agents (CrewAI):** **Planner → Builder → Auditor → Saboteur** (separation of duties).  
**Consensus Gate:** *A change is eligible for release only if ≥2 of 3 models/agents independently converge on the same output, and the **Auditor reproduces** it.*  
**Sabotage Gate:** *If the Saboteur can induce failure (prompt‑injection, jailbreak, spec gap), the change **fails***.  
**Human Role:** You approve **P‑gates** and any **data scope, SLO, or privacy** change. You approve **evidence bundles**, not code.

---

## C) Phases & **P‑Gates** (mapped to your artifacts)

### **Phase −1 — Meta‑Research (COMPLETED)**
Artifacts: 19 pitfalls → **G01–G20** guardrails; CrewAI selection; model roles; **10 business rules**; budget rules; revenue model; success‑probability target.

### **Phase 0 — Guardrails Infrastructure (IN PROGRESS)**
**Goal:** Make failure **impossible to merge**. **Composer‑First + Docker‑First**.  
**Blocking controls (pre‑commit/CI via docker‑compose profiles, with **pinned digests**):**
- **Secrets:** Gitleaks **v8.18.0**, TruffleHog **v3.63.2**.  
- **SAST:** Semgrep **1.50.0** (`--config=auto`) + custom rulepacks for your G‑controls.  
- **Testing strength:** Hypothesis property tests; **mutmut** mutation thresholds; coverage SLAs.  
- **SBOM & vulns:** Syft (CycloneDX) → Grype (fail on HIGH).  
- **Supply‑chain:** **SLSA** provenance; **Cosign** sign/verify; OpenSSF **Scorecard**.  
- **IaC/containers:** Checkov; Trivy fs/image; Hadolint.  
- **Observability:** **OpenTelemetry OTLP** smoke test; structured logging policy.  
- **Release safety:** **feature flags**, canary/blue‑green, auto‑rollback thresholds.  
- **Accessibility:** **WCAG 2.2 AA** acceptance tests + pre‑launch audit.  
- **Privacy:** Living **DPIA**; data map + retention; consent/transparency stubs.  
- **FinOps:** **FOCUS** ingest; forecast and budget gates (below).  
- **Policy‑as‑Code:** OPA/Rego checks make all the above *machine‑enforced*.

**P0 Exit:** All above green in CI; **compose** runner only uses `image@sha256:…`; dashboards & runbooks exist.

### **Phase 1 — AI Coding System (PLANNED)**
- CrewAI orchestrates Builder/Auditor/Saboteur with **prompt logging + audit trail**.
- **LLM safety:** OWASP LLM Top‑10 tests; schema validation for LLM I/O; scheduled red‑teaming.
- **Human oversight:** You sign Go/No‑Go and any data/SLO/privacy change.
- **Progressive rollout:** canary → % ramp → 100% … or **auto‑rollback** on breach.

**P1 Exit:** At least one feature canaried and ramped; SLOs healthy; forecast **≤ target**; DPIA & accessibility updated.

---

## D) Mapping — **19 Pitfalls → G01–G20 Guardrails (inline)**
*(Canonical list remains in your repo; this embeds the mapping so the blueprint is self‑contained. Tools are replaceable; controls are not.)*

1. Looks right, is wrong → **G04 Mutation** (mutmut), **G05 Property** (Hypothesis); complexity budgets (Radon/Xenon).  
2. Mocks/placeholders in prod → **G01** Semgrep rules; CI bans TODO/stubs; VCR network‑off.  
3. Hard‑coded secrets → **G02** Gitleaks/TruffleHog.  
4. Hallucinated packages/APIs → **G03** package allow/deny + contract tests.  
5. Security drift in refactors → **G06** SAST (Semgrep/Bandit).  
6. Rigged tests/false confidence → **G04/G05** + mutation score SLAs.  
7. Over‑promising → Release gates require green controls + status log.  
8. License/provenance traps → License scan; **SBOM** attach; **provenance** attest.  
9. Prompt/toolchain injection → Prompt validation/sandbox; least‑privilege tooling.  
10. Insecure defaults → Security lint rules; hardened baselines.  
11. Phantom/stale APIs → Contract tests; Renovate/Dependabot freshness.  
12. Secret discovery by attackers → Continuous scans + rotation; scoped tokens.  
13. Context loss → Business‑context injection; ADRs for decisions.  
14. Bad docs → Doc‑coverage gates; Sphinx/MkDocs CI.  
15. Best‑practice violations → Style/arch linters; policy‑as‑code.  
16. Inconsistent style/logic → Formatting & types; ADR conventions.  
17. Reinventing the wheel → **Composer‑First** policy; templates before custom.  
18. Bad dependency mgmt → **G07** emergency dep plan; pip‑audit/Safety; Renovate.  
19. Late prod‑env testing → **Docker‑First**; CI mirrors prod; container/IaC scans.

---

## E) **Policy‑as‑Code** (OPA/Rego) — enforce what matters

> **Budget ceiling (FOCUS)** — block PR if forecast exceeds ceiling

```rego
package ci.finops

default allow := false

forecast_dollars := input.focus.weekly_forecast_usd
target := 300
ceiling := 500

deny[msg] {{
  forecast_dollars > ceiling
  msg := sprintf("Budget ceiling exceeded: $%.2f > $%d", [forecast_dollars, ceiling])
}}

warn[msg] {{
  forecast_dollars > target * 1.15
  msg := sprintf("Forecast > target+15%%: $%.2f > $%.2f (add optimization plan)", [forecast_dollars, target*1.15])
}}

allow {{
  not deny[_]
}}
```

> **Provenance & signing required (SLSA + Cosign)**

```rego
package ci.supplychain

default allow := false

has_sbom := input.build.sbom_attached
has_provenance := input.build.slsa_provenance
cosign_verified := input.build.cosign_verify == "OK"

deny["Missing SBOM"] {{ not has_sbom }}
deny["Missing SLSA provenance"] {{ not has_provenance }}
deny["Cosign verify failed"] {{ not cosign_verified }}

allow {{ has_sbom; has_provenance; cosign_verified }}
```

> **Observability smoke (OTLP trace must exist)**

```rego
package ci.observability

default allow := false

deny["No OTLP trace from preview env"] {{
  count(input.preview_env.last_5min_trace_ids) == 0
}}

allow {{
  count(input.preview_env.last_5min_trace_ids) > 0
}}
```

---

## F) **Rollout Policy** (canary thresholds, auto‑rollback)
- **Start:** 1% traffic, then 10% → 25% → 100% if all guardrails pass.
- **Rollback triggers (any true):**
  - Error‑budget burn rate > **X%** over **Y minutes**
  - P95 latency > **1.2 × SLO** for **Y minutes**
  - 3 consecutive **accessibility checks** fail
  - Saboteur produces a confirmed exploit or spec break
- **Automation:** Deployment controller reads KPIs tagged by version and decides *continue vs rollback*; humans are alerted but not in the loop unless triggered.

---

## G) **Evidence Bundle per PR** (what you approve)
- CI: tests (unit/property/mutation), SAST, IaC/container scans, secrets & license clean.
- **SBOM (CycloneDX)** + **Grype** results, **SLSA provenance**, **Cosign verify** output.
- **OTLP trace** IDs from preview env + SLO deltas.  
- **Accessibility checks** (WCAG 2.2 AA) and **DPIA diff**.  
- **Cost Notes** with **FOCUS** extract + forecast; if > target+15% → optimization plan.

---

## H) **Pinned Images** (no `:latest` — use digests)
- All compose services use **`image@sha256:<digest>`**.  
- Maintain a `deps/containers.lock` file with image → digest mappings and rotation policy.

---

## I) **Appendix 1 — Five Failures → Guardrail Prevention Map (fill this in)**
| Past Failure | Root Cause Pattern | Guardrail(s) that prevent repeat | Evidence you’ll require next time |
|---|---|---|---|
| #1 | (e.g., “spec drift, mocks in prod”) | G01, G04, G05 | Semgrep stub‑ban; mutation score ≥ SLA |
| #2 |  |  |  |
| #3 |  |  |  |
| #4 |  |  |  |
| #5 |  |  |  |

---

## J) **Appendix 2 — Standards this aligns to (auditor crib‑sheet)**
- **Secure SDLC:** **NIST SSDF** (SP 800‑218).  
- **AI additions:** **NIST SP 800‑218A** (Generative AI profile) + **NIST AI RMF 1.0** + **ISO/IEC 42001** + **EU AI Act – Human Oversight (Art. 14)**.  
- **Supply chain:** **SLSA** provenance + **Sigstore/Cosign** signing; **SBOM** required.  
- **Observability:** **OpenTelemetry OTLP** (traces/metrics/logs).  
- **Delivery performance:** **DORA Four Keys**.  
- **Accessibility:** **WCAG 2.2 AA**.  
- **FinOps:** **FOCUS** cost/usage normalization driving budget gates.

---

## K) **How you’ll run a week (solo human)**
- **Mon (90m):** Review NSM/OKRs; **DORA** & **FOCUS** dashboards; approve milestone.  
- **Mid‑week (60–90m):** AI demo in preview; verify **evidence bundle**; accept or send back.  
- **Fri (60m):** Postmortems; SLO/error‑budget check; approve cost optimizations; publish changelog.

*End of file.*
