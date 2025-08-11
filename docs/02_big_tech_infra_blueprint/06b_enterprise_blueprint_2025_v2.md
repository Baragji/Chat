# enterprise_blueprint_2025_v2.md
**Tailored for: Solo non‑coder founder + AI dev team — *Phase −1/0/1* structure**  
Timestamp: 2025-08-11 12:46 UTC

> This version aligns 1:1 with your research artifacts: Phase −1 → Phase 0 → Phase 1, Composer‑First + Docker‑First, adversarial multi‑agent (CrewAI) roles, 19 failure patterns → G01–G20 guardrails, and **hard budget gates ($300 target / $500 ceiling)** enforced with FOCUS data.

---

## 0) Operating Model (unchanged intent, aligned to your roles)
- **Human (you):** Product/Risk Owner, final approver at each phase gate; no code review required.
- **CrewAI roles (explicit):** **Planner → Builder → Auditor → Saboteur** (adversarial trinity + planner).  
  - *Planner:* scope, RFCs, acceptance criteria.  
  - *Builder:* implements.  
  - *Auditor:* verifies against specs/controls.  
  - *Saboteur:* red‑team & break tests.  
- **Separation of duties:** Builder cannot approve itself; Auditor & Saboteur must independently approve.

**Evidence artifacts you approve:** decision narrative, CI run, SBOM + provenance, signature verify, OTel traces, SLO dashboard, cost report.

---

## 1) Phase Structure & Quality Gates (renamed to match your plan)

### **Phase −1 — Meta‑Research (COMPLETED)**  
Artifacts: 19 failure patterns, 20‑point guardrail framework, business context package, tools catalog, budget constraints, adversarial roles.

### **Phase 0 — Guardrails Infrastructure (IN PROGRESS)**  
**Goal:** Make failure *impossible to merge*. Composer‑First + Docker‑First.

Controls (all **blocking** in pre‑commit/CI, via compose profiles):  
- **Secrets:** Gitleaks **v8.18.0**, TruffleHog **v3.63.2**.  
- **SAST:** Semgrep **1.50.0** (`--config=auto`) + policy rules.  
- **Testing strength:** Hypothesis property tests; **mutmut** mutation thresholds.  
- **SBOM & vulns:** Syft (CycloneDX) → Grype (fail on HIGH).  
- **Supply chain:** SLSA provenance; **Cosign** sign/verify; OpenSSF Scorecard.  
- **IaC/containers:** Checkov; Trivy fs/image; hadolint.  
- **Observability:** OpenTelemetry (OTLP) smoke; structured logs baseline.  
- **Release safety:** feature flags, canary/auto‑rollback thresholds.  
- **Accessibility:** WCAG 2.2 AA criteria in acceptance tests.  
- **Privacy:** living DPIA; data map & retention.  
- **Cost:** FOCUS‑based cost ingest; *budget policy* below.

**Exit gate P0:** All above green in CI; dashboards and runbooks exist; compose file uses **pinned image digests**.

### **Phase 1 — AI Coding System (PLANNED)**  
**Goal:** Autonomously deliver increments under the same gates.  
- CrewAI orchestrates Planner/Builder/Auditor/Saboteur with **prompt logging & audit trail**.  
- LLM safety: OWASP LLM Top‑10 tests, schema validation for LLM I/O, regular red‑teaming.  
- Human oversight: you sign Go/No‑Go and any data/SLO/privacy changes.

**Exit gate P1:** At least one feature delivered via canary→ramp; SLOs healthy; cost within budget; accessibility & DPIA updated.

---

## 2) Budget & FinOps Policy (hard gates)

- **Weekly budget target:** **${300}**. **Absolute ceiling:** **${500}**.  
- **Data source:** **FOCUS‑formatted** cost & usage from vendors; keep raw CSV snapshots.  
- **Build gates:** Fail PR if forecast > target by >15% *and* no remediation plan. **Block release** if forecast > ceiling; require scope/capacity change.  
- **Reports:** Weekly DORA + FOCUS digest to you; PRs must include “Cost Notes” section.

---

## 3) Mapping your 19 failure patterns → G01–G20 guardrails (inline)

*(Canonical list lives in your catalog and remediation log. This section embeds the mapping so the blueprint is self‑contained. Tool brands are replaceable; controls are not.)*

1. **Looks right, is wrong** → G04 Mutation testing (mutmut), G05 Property tests (Hypothesis), complexity budgets (Radon/Xenon).  
2. **Mocks & placeholders in prod** → G01 Mock‑detection Semgrep rules; CI bans TODO/stubs; VCR network‑off.  
3. **Hard‑coded secrets** → G02 Secrets (Gitleaks/TruffleHog).  
4. **Hallucinated packages/APIs** → G03 Package verification; allow/deny lists; contract tests.  
5. **Security degradation over refactors** → G06 SAST (Semgrep/Bandit).  
6. **Rigged tests/false confidence** → G04/G05 plus coverage thresholds; mutation score SLAs.  
7. **Over‑promising/under‑delivering** → Release gates tied to green controls + status log.  
8. **License/provenance traps** → License scan; **SBOM** attach; provenance attestations.  
9. **Prompt/toolchain injection** → Policy sandboxing; prompt validation; least‑privilege tooling.  
10. **Insecure defaults/patterns** → Security lint rules; hardened baselines.  
11. **Phantom/stale APIs** → Contract tests; Dependabot/Renovate freshness.  
12. **Secret discovery by attackers** → Continuous scans + rotation; scoped tokens.  
13. **Context loss** → Business‑context package auto‑injection; ADR discipline.  
14. **Bad docs** → Doc coverage gates; Sphinx/MkDocs CI.  
15. **Best‑practice violations** → Style/arch linters (Ruff/import‑linter); CI policy.  
16. **Inconsistent style/logic** → Formatting & type gates; ADR conventions.  
17. **Reinventing the wheel** → **Composer‑First policy**; templates before custom.  
18. **Bad dependency mgmt** → G07 emergency dep plan; pip‑audit/Safety; Renovate.  
19. **Late prod‑env testing** → Docker‑First; CI mirror env; container/IaC scans.

---

## 4) Minimal “compose” runner (pinned digests required)
See `docker-compose.guardrails.yml` in repo. Replace any tags with `image@sha256:...`. Example pins carried from your remediation log:  
- `zricethezav/gitleaks:v8.18.0`  
- `trufflesecurity/trufflehog:v3.63.2`  
- `semgrep/semgrep:1.50.0`  
(others per your catalog; pin exact digests before enabling in CI.)

---

## 5) Evidence bundle per PR (what you require to approve)
- CI: tests, SAST, IaC/container scans, secrets & license clean.  
- **SBOM (CycloneDX)** + **Grype** results.  
- **Provenance attestation (SLSA)** + **Cosign verify** output.  
- **OpenTelemetry trace** ID from preview env + SLO delta.  
- **Accessibility checks** (WCAG 2.2 AA) + **DPIA** diff.  
- **Cost Notes** with **FOCUS** extract + forecast.

---

## 6) Phase gates recap (P‑gates instead of G‑gates)
- **P−1:** Research artifacts complete (already ✅).  
- **P0:** Guardrails enforceable end‑to‑end; compose runner pinned; dashboards live.  
- **P1:** First AI‑delivered feature through canary; SLOs met; cost ≤ target; privacy/accessibility signed.

---

## 7) Appendix — Standards this blueprint aligns to (for auditors)
- **Secure SDLC:** NIST **SSDF** (SP 800‑218) + AI‑specific addendum (SP 800‑218A IPD).  
- **Supply chain:** **SLSA** provenance; **Sigstore/Cosign** signing; OpenSSF **Scorecard**.  
- **Observability:** **OpenTelemetry OTLP** traces/metrics/logs.  
- **Delivery performance:** **DORA Four Keys**.  
- **Accessibility:** **WCAG 2.2 AA**.  
- **AI governance (if product uses AI):** **EU AI Act – Human Oversight**, **ISO/IEC 42001**, **NIST AI RMF**, **OWASP LLM Top‑10**.  
- **FinOps:** **FOCUS** cost & usage normalization for budget gates.

*End of file.*
