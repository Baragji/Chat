# Compatibility Matrix (Template)

Use this to record *known-good* versions for runtimes, frameworks, and key libraries, plus test status. Update whenever Renovate/Dependabot propose changes.

| Area | Component | Version / Digest | Status | Tests (Unit/Integration/E2E) | Notes |
|---|---|---|---|---|---|
| Runtime | Python | 3.12.x | ✅ | U/I/E2E pass | |
| Runtime | Node.js | 20.x | ✅ | U/I/E2E pass | |
| Container | Base Image | python:3.12-slim@sha256:... | ✅ | Build + smoke | |
| Package | numpy | 2.1.x | ✅ | U/I | |
| Package | fastapi | 0.115.x | ✅ | U/I/E2E | |
| Infra | postgres | 16.x | ✅ | I/E2E | |
| Actions | actions/checkout | v4 | ✅ | CI | |

**Policy:** If a proposed update fails tests, record the failure and pin the last known-good version here; open an issue to track remediation.

**Pip constraints:** Mirror this matrix in `constraints/python-constraints.txt` and pass it via `-c constraints/python-constraints.txt` in all `pip install` commands.

