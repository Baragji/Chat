package ci.supplychain

default allow := false

policy_mode := input.build.policy_mode
strict := policy_mode == "release"

has_sbom := input.build.sbom_attached
has_provenance := input.build.slsa_provenance
cosign_verified := input.build.cosign_verify == "OK"

deny["Missing SBOM"] {
  not has_sbom
}

deny["Missing SLSA provenance"] {
  strict
  not has_provenance
}

deny["Cosign verify failed"] {
  strict
  not cosign_verified
}

allow {
  has_sbom
  (not strict) or (has_provenance and cosign_verified)
}
