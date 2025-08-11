# Red‑line Delta (from enterprise_blueprint_2025.md → v2)

1) **Phases renamed**: G0–G8 → **Phase −1 / 0 / 1** to mirror your research & implementation flow.  
2) **Agent roles corrected**: generic roles → **CrewAI Planner/Builder/Auditor/Saboteur** with separation of duties.  
3) **Composer‑First enforcement**: explicit **docker‑compose.guardrails.yml** runner with **pinned image digests** and example version pins (Gitleaks v8.18.0, TruffleHog v3.63.2, Semgrep 1.50.0).  
4) **Inline mapping**: embeds your **19 failure patterns → G01–G20 guardrails** so the blueprint is self‑contained.  
5) **Budget gates added**: **$300 weekly target / $500 ceiling** using **FOCUS** cost data; PR/release blocks tied to forecasts.  
6) **Evidence bundle defined**: PRs must attach **SBOM + provenance + Cosign verify**, **OTLP trace**, **WCAG 2.2** checks, **DPIA diff**, and **Cost Notes**.  
7) **Appendix for auditors**: cites SSDF, SLSA, Sigstore, OTLP, DORA, WCAG 2.2, EU AI Act, ISO/IEC 42001, NIST AI RMF, OWASP LLM Top‑10, and FOCUS.

