package ci.vulns

default allow := false

allow {
  not deny[_]
}

deny[msg] {
  some i
  comp := input.depcheck.dependencies[i]
  some j
  vuln := comp.vulnerabilities[j]
  vuln.cvssScore >= 8.0
  msg := sprintf("High/critical CVE via Dependency-Check: %s (CVSS %.1f)", [vuln.name, vuln.cvssScore])
}

deny[msg] {
  some i
  finding := input.pipaudit.dependencies[i]
  some v
  vuln := finding.vulns[v]
  msg := sprintf("Python vulnerability via pip-audit: %s %s", [finding.name, vuln.id])
}

deny[msg] {
  input.npmaudit.metadata.vulnerabilities.critical > 0
  msg := "npm audit found critical vulnerabilities"
}
