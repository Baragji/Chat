# Dependency Rollback Playbook

1) Stop rollout / disable flag.
2) Re-pin to last known-good:
   - Python: edit `constraints/python-constraints.txt` (compiled).
   - Node: exact versions in `package.json` + lockfile.
   - Docker: prior `image@sha256:...` digest.
3) Document in Compatibility Matrix.
4) Verify: CI green, preview OTLP smoke ok, SLOs stable.
5) Remediate: open issue; add guardrail rules; increase `minimumReleaseAge` if needed.
