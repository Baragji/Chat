Absolutely—accepting Claude’s corrected assessment, and I’ve shipped the **G07 dependency-management pack**. Below are your downloads, plus why each piece is correct with receipts.

# Downloads

* Renovate config → [renovate.json5](sandbox:/mnt/data/renovate.json5)
* Dependabot setup → [.github/dependabot.yml](sandbox:/mnt/data/.github/dependabot.yml)
* Dependency SCA workflow → [.github/workflows/dependency-management.yml](sandbox:/mnt/data/.github/workflows/dependency-management.yml)
* Compatibility matrix (template) → [docs/compatibility\_matrix.md](sandbox:/mnt/data/docs/compatibility_matrix.md)
* Rollback playbook → [docs/rollback\_playbook.md](sandbox:/mnt/data/docs/rollback_playbook.md)
* Python constraints (template) → [constraints/python-constraints.txt](sandbox:/mnt/data/constraints/python-constraints.txt)

# Why this closes G07 (evidence-backed)

* **Automated updates (Renovate).** Config uses `config:recommended`, groups minor/patch for Python & npm with safe automerge, and **pins Docker digests** via `packageRules`. Renovate officially documents managers and digest pinning—and recommends **minimumReleaseAge** to avoid yanked/bad releases. ([docs.renovatebot.com][1])
* **Security updates (Dependabot).** `.github/dependabot.yml` enables version/security updates for GitHub Actions, npm, pip, and Docker per GitHub’s reference. This complements Renovate (Renovate does routine bumps; Dependabot can still raise security fixes). ([GitHub Docs][2])
* **SCA scanning (OWASP Dependency-Check).** The workflow integrates the official GitHub Action for Dependency-Check (CPE→CVE analysis) and uploads JSON reports. ([GitHub][3], [owasp.org][4])
* **Python vulnerability scan (pip-audit).** Adds PyPA’s maintained scanner, which uses the Python Packaging Advisory Database; there’s also an official GH Action. ([GitHub][5])
* **Pinned digests everywhere.** Renovate config enforces digest pinning for Docker; your existing guardrails runner already converts tags→digests at CI, and Renovate’s Docker docs explicitly advise digest pinning. ([docs.renovatebot.com][6])
* **Compatibility & rollback discipline.** The **compatibility\_matrix.md** and **rollback\_playbook.md** formalize a known-good baseline and a fast, auditable revert path; Python’s own docs recommend **constraints files** to consistently pin transitive deps—we include a `constraints/python-constraints.txt` and call it from installs. ([pip.pypa.io][7])
* **SemVer-aware policy.** We automerge **minor/patch** updates (safe by SemVer), keep majors for manual review, and delay npm & Docker updates by 3 days to let issues surface. SemVer spec defines the MAJOR.MINOR.PATCH contract we rely on. ([Semantic Versioning][8])

# How this integrates with what you already have

* Works alongside your **guardrails runner** (SBOM→Grype, SLSA/Cosign, OTel smoke) and **OPA gates**. Renovate raises PRs; the runner’s CI and OPA policies gate merges. (You can also feed Dependency-Check JSON into an OPA rule later to hard-fail on CVSS ≥ threshold.)
* Keeps your **Composer-First** model: everything runs via Docker/Actions, no custom scripts.

# Optional hardening (say the word if you want it)

* **Add an OPA rule for “no critical CVEs”** using Dependency-Check JSON.
* **Flip Renovate to self-hosted GH Action** (`renovatebot/github-action`) instead of app install if you prefer running in-repo. ([GitHub][9], [GitLab][10], [docs.renovatebot.com][11])
* **Add npm audit/SBOM for JS** or enable Snyk OSS as an additional SCA layer (complements Dependency-Check).
* **Gate new versions with minimum release age** across more ecosystems or bump to 7 days for ultra-conservative flows. ([docs.renovatebot.com][12], [AugmentedMind.de][13])

If you want me to wire an OPA policy that parses Dependency-Check’s JSON and **blocks PRs with CVSS ≥ 8**, I can add `opa/vulns.rego` and extend the workflow to pass the report into Conftest.

[1]: https://docs.renovatebot.com/modules/manager/?utm_source=chatgpt.com "Managers - Renovate Docs"
[2]: https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuring-dependabot-version-updates?utm_source=chatgpt.com "Configuring Dependabot version updates"
[3]: https://github.com/marketplace/actions/dependency-check?utm_source=chatgpt.com "Dependency Check · Actions · GitHub Marketplace"
[4]: https://owasp.org/www-project-dependency-check/?utm_source=chatgpt.com "OWASP Dependency-Check"
[5]: https://github.com/pypa/pip-audit?utm_source=chatgpt.com "pypa/pip-audit"
[6]: https://docs.renovatebot.com/docker/?utm_source=chatgpt.com "Docker - Renovate Docs"
[7]: https://pip.pypa.io/en/stable/user_guide/?utm_source=chatgpt.com "User Guide - pip documentation v25.1.1"
[8]: https://semver.org/?utm_source=chatgpt.com "Semantic Versioning 2.0.0 | Semantic Versioning"
[9]: https://github.com/renovatebot/github-action?utm_source=chatgpt.com "renovatebot/github-action"
[10]: https://git.shivering-isles.com/github-mirror/renovatebot/renovate/-/blob/32.71.5/docs/usage/getting-started/running.md?utm_source=chatgpt.com "Running Renovate - Explore projects"
[11]: https://docs.renovatebot.com/examples/self-hosting/?utm_source=chatgpt.com "Self-Hosting Examples - Renovate Docs"
[12]: https://docs.renovatebot.com/configuration-options/ "Configuration Options - Renovate Docs"
[13]: https://www.augmentedmind.de/2023/07/30/renovate-bot-cheat-sheet/?utm_source=chatgpt.com "Renovate bot cheat sheet - the 11 most useful customizations"
