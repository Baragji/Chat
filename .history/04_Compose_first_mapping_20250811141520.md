Awesome — here’s the **complete, composer-first mapping** from your **19 AI pitfalls** → **guardrails**, with **OSS tools** and **how we’ll enforce** them (pre-commit + CI + Docker). I’m aligning to your pitfall list in `01_ai_dev_pitfalls.md`.&#x20;

---

### 1) Hidden mocks / fake implementations

* **Guardrail:** Block PRs that contain placeholders (e.g., `raise NotImplementedError`, `pass`, `TODO`, “stub”), or tests that pass only with mocks.
* **Tools:** Semgrep custom rules; mutation testing (mutmut) to prove tests fail when logic is broken; pytest “network off” + VCR for real HTTP replay. ([semgrep.dev][1], [radon.readthedocs.io][2], [GitHub][3], [vcrpy.readthedocs.io][4], [PyPI][5])
* **Enforce:** `pre-commit` + CI step runs Semgrep with custom rules; `pytest -m "not integration"` with VCR in CI to avoid live calls.

### 2) Hard-coded secrets

* **Guardrail:** Reject secrets at commit and in CI.
* **Tools:** Gitleaks, TruffleHog, (optionally) detect-secrets; GH native secret scanning if you host on GitHub. ([GitHub][6], [docs.astral.sh][7], [microsoft.github.io][8], [GitHub Docs][9])
* **Enforce:** `pre-commit` scan + CI job. Docker image `zricethezav/gitleaks` to keep it portable. ([hub.docker.com][10])

### 3) Production data deletion / dangerous operations

* **Guardrail:** Pattern-match for destructive ops without safety (e.g., `DROP *`, `rm -rf`, bulk deletes without filters).
* **Tools:** Semgrep rules for dangerous patterns; policy-as-code checks (OPA/Conftest) for IaC. ([semgrep.dev][1], [mutmut.readthedocs.io][11])
* **Enforce:** Semgrep rulepack + Conftest in CI for config and IaC.

### 4) Environment inconsistency (“works on my machine”)

* **Guardrail:** Reproducible, pinned toolchain + containerized checks.
* **Tools:** Docker + hadolint; lock files (pip-tools/poetry/uv). ([pip-tools.readthedocs.io][12], [docs.renovatebot.com][13], [semgrep.dev][14])
* **Enforce:** All guardrails run via Docker images; PRs blocked if `hadolint` fails. ([docs.pytest.org][15])

### 5) Business-logic bypass

* **Guardrail:** Spec-first tests (pytest + property-based tests) and API contract tests; Semgrep rules to enforce auth/guard decorators.
* **Tools:** pytest, Hypothesis; Pact for API contracts; Semgrep rule “routes must have @auth”. ([radon.readthedocs.io][2], [substack.com][16], [semgrep.dev][1])
* **Enforce:** CI runs unit/contract/property tests; Semgrep blocks missing guards.

### 6) Technical debt / code smells

* **Guardrail:** Complexity & duplication budgets; dead-code bans.
* **Tools:** Radon/Xenon for complexity; Vulture for dead code; Ruff/Black/isort for hygiene. ([mypy.readthedocs.io][17], [GitHub][18], [docs.astral.sh][19], [black.readthedocs.io][20], [pycqa.github.io][21])
* **Enforce:** Failing thresholds on complexity; Vulture must report 0 criticals; Ruff error-on-violation.

### 7) Security vulns in code (SAST)

* **Guardrail:** Block on high-severity SAST findings.
* **Tools:** Semgrep (security rules), Bandit for Python. ([semgrep.dev][14], [pip-tools.readthedocs.io][12])
* **Enforce:** CI job: `semgrep --config auto --error .` and `bandit -r .` block PRs. ([semgrep.dev][22])

### 8) Dependency conflicts / vulnerable packages

* **Guardrail:** Only allow resolvable, pinned deps; block when vulns present.
* **Tools:** Renovate (self-host OSS) for updates; pip-audit & Safety for Python vulns. ([commitlint.js.org][23], [GitHub][24])
* **Enforce:** Renovate PRs; CI runs `pip-audit` / `safety` and fails on >0 highs.

### 9) License compliance violations

* **Guardrail:** License policy allowlist + SBOM.
* **Tools:** ScanCode Toolkit (OSS license detection); Syft (SBOM) + Grype (vuln scan). ([radon.readthedocs.io][2], [GitHub][25])
* **Enforce:** CI job generates SBOM via Syft, checks licenses via ScanCode, scans vulns via Grype.

### 10) Placeholder tests / vanity coverage

* **Guardrail:** Mutation testing must kill mutants; coverage threshold with branch coverage.
* **Tools:** mutmut + coverage.py. ([substack.com][16], [PyPI][26])
* **Enforce:** PR must meet `coverage --fail-under` and `mutmut` kill-ratio.

### 11) “Hallucinated” packages/APIs

* **Guardrail:** Verify every import/package exists and pins resolve; forbid unknown registries.
* **Tools:** pip-tools/poetry/uv for resolution + hashes; Semgrep rule to flag “from non-existent pkg”; API contract tests (Pact). ([pip-tools.readthedocs.io][12], [python-poetry.org][27], [docs.astral.sh][28])
* **Enforce:** CI step: `pip-compile --generate-hashes` (or `poetry lock`/`uv lock`) must succeed. ([pip-tools.readthedocs.io][12])

### 12) Leaky or flaky integration tests (live network)

* **Guardrail:** No live calls in CI; deterministic fixtures.
* **Tools:** VCR.py + pytest-recording/pytest-vcr (block network). ([vcrpy.readthedocs.io][4], [PyPI][5], [pytest-vcr.readthedocs.io][29])
* **Enforce:** `--record=none` in CI; fail if HTTP without cassette. ([pytest-vcr.readthedocs.io][30])

### 13) Missing docs / unreadable code

* **Guardrail:** Docstring coverage & auto docs.
* **Tools:** docstr-coverage; Sphinx/MkDocs in CI. ([PyPI][31])
* **Enforce:** Fail if docstring coverage < target.

### 14) Weak typing / unsound interfaces

* **Guardrail:** Type checker must pass; forbid `Any` leakage.
* **Tools:** MyPy or Pyright. ([pip-tools.readthedocs.io][12], [OpenTelemetry][32])
* **Enforce:** CI step fails on type errors.

### 15) Insecure containers / Dockerfiles

* **Guardrail:** Lint Dockerfiles, scan images, sign artifacts.
* **Tools:** hadolint; Trivy (image/IaC/secrets); Syft SBOM + Cosign signing. ([docs.pytest.org][15], [trivy.dev][33], [substack.com][16])
* **Enforce:** Block on criticals; require `cosign verify` and SBOM attached. ([Sigstore][34])

### 16) IaC misconfig / drift

* **Guardrail:** Scan Terraform/K8s; enforce policies.
* **Tools:** Checkov; OPA/Conftest. ([hypothesis.readthedocs.io][35], [mutmut.readthedocs.io][11])
* **Enforce:** CI blocks on Checkov HIGH/CRITICAL; policy tests via Conftest.

### 17) Missing observability / logging

* **Guardrail:** Require structured logging/traces & ban `print` in prod.
* **Tools:** Semgrep rule for logging policy; OpenTelemetry/structlog present in runtime. ([OpenTelemetry][32])
* **Enforce:** Semgrep blocks missing logging in handlers; CI ensures OTEL config files present.

### 18) Performance regressions

* **Guardrail:** Performance budgets checked in CI.
* **Tools:** pytest-benchmark; (optional) external tracker if you want history. ([pytest-benchmark.readthedocs.io][36])
* **Enforce:** Fail PR if p95 or ops/sec deviates beyond threshold across baselines.

### 19) Prompt-/LLM-specific risks (jailbreaks, toxic output, unstructured JSON)

* **Guardrail:** Validate LLM I/O + red-team regularly.
* **Tools:** Guardrails AI (schema/validators); NVIDIA Garak for red-teaming. ([guardrails][37], [GitHub][38])
* **Enforce:** Unit tests wrap LLM calls with Guardrails; scheduled Garak runs on prompts set.

---

## Composer-first Docker skeleton (portable guardrail runner)

Keep it simple: pin images, mount repo read-only, and fail fast. (Matches your “Docker-First + Composer-First” approach. )

```yaml
# docker-compose.guardrails.yml
version: "3.8"
services:
  gitleaks:
    image: zricethezav/gitleaks:<pin>
    command: detect --source /repo --no-banner --redact --verbose
    volumes: ["./:/repo:ro"]
  semgrep:
    image: semgrep/semgrep:<pin>
    command: scan --config=auto --error /src
    volumes: ["./:/src:ro"]
  bandit:
    image: python:3.12-slim
    working_dir: /src
    command: bash -lc "pip install bandit && bandit -r ."
    volumes: ["./:/src:ro"]
  ruff:
    image: python:3.12-slim
    working_dir: /src
    command: bash -lc "pip install ruff && ruff check --exit-zero . && ruff format --check ."
    volumes: ["./:/src:ro"]
  pip_audit:
    image: python:3.12-slim
    working_dir: /src
    command: bash -lc "pip install pip-audit && pip-audit -r requirements.txt"
    volumes: ["./:/src:ro"]
  safety:
    image: python:3.12-slim
    working_dir: /src
    command: bash -lc "pip install safety && safety check -r requirements.txt"
    volumes: ["./:/src:ro"]
  hadolint:
    image: hadolint/hadolint:<pin>
    command: hadolint /src/Dockerfile
    volumes: ["./:/src:ro"]
  trivy:
    image: aquasec/trivy:<pin>
    command: image --exit-code 1 --severity HIGH,CRITICAL yourimage:tag
    volumes: ["/var/run/docker.sock:/var/run/docker.sock"]  # if scanning local image
  syft:
    image: anchore/syft:<pin>
    command: packages dir:/src --output cyclonedx-json --file /src/sbom.json
    volumes: ["./:/src"]
  grype:
    image: anchore/grype:<pin>
    command: dir:/src --fail-on high
    volumes: ["./:/src:ro"]
```

* Official images/docs for **Semgrep**, **Trivy**, **Syft**, **Gitleaks** linked here for reference. ([semgrep.dev][22], [hub.docker.com][39], [GitHub][25])

---

## CI hooks to make it bite (blocking gates)

* **Pre-commit (local):** gitleaks, ruff, black, isort, semgrep, mypy. (Framework: `pre-commit`.) ([conventionalcommits.org][40])
* **PR (CI):** run compose services above; `pytest` (+ `coverage.py`), Hypothesis, mutmut; VCR network-off; pip-audit/Safety; hadolint; Trivy; Syft→Grype; Checkov/Conftest for IaC. ([PyPI][26], [radon.readthedocs.io][41], [substack.com][16], [pytest-vcr.readthedocs.io][30], [trivy.dev][33], [hypothesis.readthedocs.io][35], [mutmut.readthedocs.io][11])
* **Release:** Cosign-sign artifacts; attach SBOM (Syft). ([Sigstore][34], [GitHub][25])

---

## Notes tying back to your docs

* This plan respects your **Composer-First + Docker-First** correction and the staged guardrail approach already captured in the master logs.
* Tools listed here overlap with your **catalog** and **research-backed tools**; this mapping just makes them executable and blocking.

If you want, I’ll **generate** the `docker-compose.guardrails.yml`, a `pre-commit-config.yaml`, and a **GitHub Actions** workflow that wires every gate above (using pinned images/versions).
