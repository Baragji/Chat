# Research-Backed Tools (Archived)

> Archived: This tools list has been merged into `03_Catalog_of_tools.md` (canonical). Keep this file only as a dated source appendix.

## **Consolidated List of Code Quality and Security Tools**

This document contains a comprehensive list of tools, systems, resources, and workflows for automatically checking and fixing code issues, extracted from the provided files.

### **I. Code Quality & Style**

* **Ruff:** Comprehensive linting, import sorting, and security checks (via Bandit integration).  
* **Black:** Opinionated, automatic code formatting.  
* **isort:** Organizes and sorts imports.  
* **autoflake:** Removes unused imports and variables.  
* **docformatter:** Formats docstrings.  
* **Flake8:** Pluggable linter and style checker.  
* **Unimport:** Removes unused imports.

### **II. Type Safety & Static Analysis**

* **MyPy:** Static type checker for Python.  
* **Pyright:** Fast type checker from Microsoft.  
* **Pyre:** A performant type checker from Facebook.  
* **Pylint:** Comprehensive static code analysis tool.  
* **Vulture:** Finds unused (dead) code.  
* **Radon:** Measures code complexity (Cyclomatic Complexity, etc.).  
* **Xenon:** Monitors code complexity against configurable thresholds.  
* **CodeScene:** Analyzes commit history and version control patterns with ML to identify code health issues, technical debt, and behavioral hotspots.

### **III. AI-Powered Code Review & Refactoring**

* **GitHub Copilot Reviewer / GitHub Copilot X:** Agentic review tools from GitHub.  
* **Cursor BugBot:** AI-based reviewer integrated into the Cursor editor.  
* **CodeRabbit:** Provides context-aware suggestions and annotations directly in pull requests.  
* **Graphite:** AI-powered code review and stacking platform.  
* **Greptile:** AI tool for understanding and navigating codebases.  
* **Sourcery:** Provides on-the-fly refactoring suggestions in the IDE.  
* **Zencoder:** Analyzes entire repositories to understand architectural intent and suggest fixes.  
* **Augment Code:** A full-stack AI agent for code review and generation.  
* **GPT-4o, Claude 4 (Sonnet), Gemini Pro 1.5:** Foundational LLMs for code review, often used in multi-step, self-refining pipelines.  
* **CodeT5/CodeBERT:** Specialized models for code-related tasks.

### **IV. AI-Powered Testing & QA**

* **Testim / Mabl / Functionize / Testsigma / ACCELQ / TestRigor / Katalon GPT:** AI-augmented platforms that generate, maintain, and self-heal test cases, particularly for UI and API flows.  
* **Code Intelligence:** An AI-driven platform for fuzz testing and vulnerability detection.

### **V. Security Analysis (SAST, DAST, SCA, Secrets)**

* **Bandit:** Finds common security issues in Python code.  
* **Semgrep:** Fast, static analysis for finding bugs and enforcing code standards.  
* **CodeSonar:** Advanced, inter-procedural SAST that analyzes source and binary code for complex vulnerabilities and compliance with safety standards.  
* **Snyk Code / Snyk Open Source:** Commercial tool for SAST and Software Composition Analysis (SCA).  
* **SonarQube:** A platform for continuous inspection of code quality and security.  
* **Qodana:** A code quality platform by JetBrains that includes security checks.  
* **CodeQL:** Semantic code analysis engine for finding vulnerabilities.  
* **HackerOne Code:** Scans commits for OWASP Top 10 issues and produces compliance reports.  
* **TruffleHog:** Scans git repositories for secrets.  
* **Gitleaks:** Detects hardcoded secrets like passwords, API keys, and tokens in git repos.  
* **detect-secrets:** Prevents secrets from being committed.  
* **CodeAnt.ai:** Scans commits and infrastructure for misconfigurations and secrets.  
* **OWASP ZAP (Zed Attack Proxy):** Open-source DAST tool.  
* **Burp Suite Enterprise / Checkmarx DAST:** Commercial DAST tools.

### **VI. Dependency & License Management**

* **Dependabot / Renovate:** Automates dependency updates.  
* **pip-audit:** Audits Python environments for packages with known vulnerabilities.  
* **Safety:** Checks Python dependencies for known security vulnerabilities.  
* **FOSSA / WhiteSource / Black Duck:** Enterprise-grade license scanning and compliance management.  
* **Licensee:** A tool to determine a project's license.  
* **CycloneDX / syft:** Standards and tools for generating a Software Bill of Materials (SBOM).

### **VII. Architecture & Design**

* **import-linter:** Enforces architectural layering and boundaries in Python.  
* **Pyreverse:** Generates UML diagrams from Python code.  
* **pydeps / graphviz:** Generates dependency graphs to visualize architecture.  
* **cohesion:** Measures class cohesion.  
* **ArchUnit:** A library for checking architecture rules (Java-focused, but concept is portable).  
* **Custom AST validators:** Custom scripts using Python's ast module to enforce specific coding standards.

### **VIII. Testing & Quality Assurance**

* **pytest:** A mature, full-featured Python testing framework.  
* **coverage.py / pytest-cov:** Measures test coverage.  
* **pytest-xdist:** Enables parallel test execution.  
* **Hypothesis / QuickCheck:** Libraries for property-based and fuzz testing.  
* **pytest-benchmark:** A fixture for benchmarking code performance.  
* **memory\_profiler / Valgrind:** Tools for memory profiling and leak detection.  
* **mutmut / cosmic-ray:** Mutation testing tools to assess test quality.  
* **pact-python:** Enables consumer-driven contract testing.  
* **Playwright:** For end-to-end and visual regression testing.

### **IX. Build, Containerization & IaC**

* **Docker:** Containerization platform.  
* **Nix / Bazel:** Tools for creating truly reproducible builds.  
* **hadolint:** A linter for Dockerfiles.  
* **Trivy / Grype / Clair:** Scanners for container image vulnerabilities.  
* **cosign / Notary:** Tools for signing and verifying container images.  
* **Checkov / TFSec / TFLint:** Scans Infrastructure as Code (IaC) for security misconfigurations.  
* **Terragrunt:** A thin wrapper for Terraform to manage configurations.  
* **Spacelift:** An orchestration platform for IaC that enforces policy-as-code.  
* **OPA/Gatekeeper:** Policy engines for enforcing rules, especially in Kubernetes.  
* **kube-score / kube-hunter:** Security scanners for Kubernetes resources.

### **X. Dynamic, Runtime & Monitoring**

* **Chaos Monkey / Gremlin / litmus:** Chaos engineering tools to test system resilience.  
* **Locust / k6 / Artillery:** Load testing frameworks.  
* **Falco / Sysdig:** Runtime security monitoring and threat detection.  
* **Pyroscope / Parca:** Continuous profiling tools for performance monitoring.  
* **ThreadSanitizer / AddressSanitizer:** Tools for detecting concurrency and memory errors.

### **XI. Observability**

* **Prometheus:** A monitoring and alerting toolkit.  
* **Grafana:** A visualization and analytics platform.  
* **Datadog / New Relic:** Commercial observability platforms.  
* **Sentry:** Error tracking and performance monitoring.  
* **structlog / OpenTelemetry:** For structured logging and distributed tracing.  
* **ELK/EFK Stack:** (Elasticsearch, Logstash/Fluentd, Kibana) for centralized logging.

### **XII. Documentation & Compliance**

* **Sphinx / MkDocs:** Documentation generators.  
* **docstr-coverage:** Measures docstring coverage.  
* **OpenAPI/Swagger:** API documentation standards.  
* **IriusRisk / Security Compass:** Tools to map threats to controls for compliance.

### **XIII. CI/CD Platforms**

* **GitHub Actions**  
* **GitLab CI**  
* **Azure DevOps**  
* **CircleCI**  
* **Jenkins**

### **XIV. Key Concepts, Workflows & Standards**

* **Zero Trust Architecture:** A security model that assumes no actor, system, or network is trusted by default.  
* **SLSA (Supply-chain Levels for Software Artifacts):** A security framework to prevent tampering and improve integrity of the software supply chain.  
* **Unified DevSecOps \+ MLOps:** A converged practice where ML models and other AI artifacts are versioned, scanned, and governed with the same rigor as application code within a single CI/CD pipeline.  
* **Agentic AI & Self-Refining LLM Workflows:** The use of autonomous AI agents that can plan, generate, test, and self-correct code in a loop until requirements and quality gates are met.  
* **Slopsquatting / Hallucinated Package Protection:** A governance practice involving whitelists, blacklists, and validation steps to prevent AI models from inventing and importing non-existent or malicious software packages.  
* **Formal AI Governance Policies:** Documented rules defining when and how AI can be used, what requires human validation, and the mandatory approval flows for AI-generated code.  
* **Monorepo:** A version control strategy where all code for multiple projects is stored in a single repository.  
* **Immutable Audit Trail:** A tamper-proof log of all actions and decisions, often using cryptographic hashing.  
* **Git Signed Commits:** Using GPG keys to sign commits, verifying the author's identity.  
* **Conventional Commits:** A specification for adding human and machine-readable meaning to commit messages.  
* **Architectural Decision Records (ADRs):** Short text files that capture important architectural decisions.  
* **C4 model:** A model for visualizing software architecture at different levels of detail.  
* **Chaos Engineering:** The practice of experimenting on a system to build confidence in its capability to withstand turbulent conditions.
