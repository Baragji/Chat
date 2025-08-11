# Dependency Rollback Playbook

**Goal:** Safely revert or quarantine a breaking dependency update within minutes.

## Triggers
- Failing CI on update PR (tests/SCA/threat rules).
- Canary degradation (error budget burn, P95 latency breach).
- New CVE crossing policy threshold.

## Immediate Actions
1. **Stop rollout** (if live): trigger auto-rollback or set flag off.
2. **Re-pin** to last known-good version:
   - Python: add/adjust in `constraints/python-constraints.txt`.
   - Node: set exact version in package.json + lockfile.
   - Docker: revert to prior `image@sha256:...` digest.
3. **Document** in the Compatibility Matrix (why, scope, next steps).

## Verification
- Re-run CI (unit/property/mutation, SAST, SCA).
- Run preview env smoke: OTLP trace present; SLO deltas acceptable.
- If prod was affected, run incident postmortem (blameless) and schedule remediation.

## Remediation Path
- Open an issue with root cause & owner.
- Add Semgrep/Conftest rule to catch this class of breakage.
- If vendor bug, subscribe to upstream issue; set Renovate `minimumReleaseAge` for that package.

## Release Gate
- Only merge once CI, SCA, and preview smoke are green **and** the Compatibility Matrix is updated.
