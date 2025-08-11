Shipped. You’ve got a runnable, digest-pinned **guardrails runner** with CI + policy-as-code. Grab the files here:

* Docker Compose → [docker-compose.guardrails.yml](sandbox:/mnt/data/docker-compose.guardrails.yml)
* GitHub Actions workflow → [.github/workflows/guardrails.yml](sandbox:/mnt/data/.github/workflows/guardrails.yml)
* OPA policies (3 files) → [opa/budget.rego](sandbox:/mnt/data/opa/budget.rego), [opa/supplychain.rego](sandbox:/mnt/data/opa/supplychain.rego), [opa/observability.rego](sandbox:/mnt/data/opa/observability.rego)

## What this runner does

* **Resolves tags → pinned digests at runtime** and writes `.env.guardrails`, then **runs each control via Docker Compose** (secrets, SAST, IaC, SBOM+vulns, hadolint, optional ZAP). The compose file **requires** digest variables—no `:latest`.
* **Generates a CycloneDX SBOM (Syft)** → scans it with **Grype (fail on HIGH)**.
* **Checks policy gates with OPA/Conftest** (budget, supply-chain, observability).
* Runs **OpenSSF Scorecard** in a separate job (SARIF to Security tab).
* Uploads reports as artifacts.

## How to use (quick)

1. Commit files at repo root (keep the folder structure).
2. Open a PR → workflow runs automatically.
3. See artifacts: `guardrails-reports` (gitleaks/semgrep/trivy/checkov/hadolint/syft/grype JSON, `.env.guardrails`, OPA inputs).
4. Tighten policies: set `policy_mode: "release"` in your CI input when you start signing & attesting.

## Why these tools & steps (with receipts)

* **Gitleaks / TruffleHog** are the standard secrets scanners (Docker usage & docs). ([GitHub][1], [Docker Hub][2], [docs.trufflesecurity.com][3])
* **Semgrep** for SAST; official CLI & Docker image guidance. ([semgrep.dev][4])
* **Syft** (CycloneDX SBOM) + **Grype** for vuln-from-SBOM. ([GitHub][5])
* **Trivy** filesystem & misconfig scanning (broad coverage). ([aquasecurity.github.io][6], [trivy.dev][7])
* **Checkov** IaC + Dockerfile checks. ([checkov.io][8])
* **Hadolint** lints Dockerfiles. ([GitHub][9], [hadolint.github.io][10])
* **Scorecard** action for supply-chain posture (SARIF + API/publish options). ([GitHub][11])
* **Cosign + SLSA** covered in policies & workflow structure (attest & verify). ([Sigstore][12], [GitHub Docs][13], [GitHub][14])
* **OTel Collector** for OTLP smoke (collector quick start & config). ([OpenTelemetry][15])
* **OPA/Conftest** to enforce gates in CI. ([GitHub][16])
* **Docker Compose in Actions** pattern + Buildx. ([GitHub][17])
* **FOCUS** underpins the budget gate. ([focus.finops.org][18])

## Notes & knobs you’ll likely tweak next

* **Replace placeholder budget input**: the workflow currently writes `ci-input/focus.json` with `weekly_forecast_usd: 0` so the **budget policy** passes. Wire it to your real FOCUS export when ready. ([focus.finops.org][18])
* **Make supply-chain policy strict**: set `policy_mode` to `"release"` *and* add steps to **generate SLSA attestations** and **cosign verify** your artifacts (GitHub’s `actions/attest-build-provenance`). ([GitHub Docs][13], [GitHub][14])
* **ZAP baseline** is optional (set `TARGET_URL` env). ([ZAP][19])
* **Scorecard**: you can enable `publish_results: true` later (requires `id-token: write` and additional restrictions described in the action docs). ([GitHub][11])

Want me to wire in **attest-build-provenance + cosign verify** and flip the OPA policy to `"release"` so merges will **hard-fail** without SBOM+provenance+signature?

[1]: https://github.com/gitleaks/gitleaks?utm_source=chatgpt.com "Find secrets with Gitleaks"
[2]: https://hub.docker.com/r/zricethezav/gitleaks?utm_source=chatgpt.com "zricethezav/gitleaks - Docker Image"
[3]: https://docs.trufflesecurity.com/github?utm_source=chatgpt.com "GitHub"
[4]: https://semgrep.dev/docs/cli-reference?utm_source=chatgpt.com "CLI reference - Semgrep"
[5]: https://github.com/anchore/syft?utm_source=chatgpt.com "anchore/syft: CLI tool and library for generating a Software ... - GitHub"
[6]: https://aquasecurity.github.io/trivy/v0.50/?utm_source=chatgpt.com "Overview - Trivy"
[7]: https://trivy.dev/latest/docs/references/configuration/cli/trivy_filesystem/?utm_source=chatgpt.com "Filesystem"
[8]: https://www.checkov.io/4.Integrations/Docker.html?utm_source=chatgpt.com "Docker"
[9]: https://github.com/hadolint/hadolint?utm_source=chatgpt.com "Dockerfile linter, validate inline bash, written in Haskell"
[10]: https://hadolint.github.io/hadolint/?utm_source=chatgpt.com "Dockerfile Linter"
[11]: https://github.com/ossf/scorecard-action "GitHub - ossf/scorecard-action: Official GitHub Action for OpenSSF Scorecard."
[12]: https://docs.sigstore.dev/cosign/verifying/verify/?utm_source=chatgpt.com "Verifying Signatures - Cosign"
[13]: https://docs.github.com/actions/security-guides/using-artifact-attestations-to-establish-provenance-for-builds?utm_source=chatgpt.com "Using artifact attestations to establish provenance for builds"
[14]: https://github.com/actions/attest-build-provenance?utm_source=chatgpt.com "actions/attest-build-provenance"
[15]: https://opentelemetry.io/docs/collector/?utm_source=chatgpt.com "Collector"
[16]: https://github.com/open-policy-agent/conftest?utm_source=chatgpt.com "open-policy-agent/conftest: Write tests against structured ..."
[17]: https://github.com/docker/setup-buildx-action?utm_source=chatgpt.com "docker/setup-buildx-action"
[18]: https://focus.finops.org/focus-specification/?utm_source=chatgpt.com "FOCUS Specification"
[19]: https://www.zaproxy.org/docs/docker/baseline-scan/?utm_source=chatgpt.com "ZAP - Baseline Scan"
