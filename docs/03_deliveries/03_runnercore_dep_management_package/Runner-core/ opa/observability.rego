package ci.observability

default allow := false

deny["No OTLP trace from preview env"] {
  count(input.preview_env.last_5min_trace_ids) == 0
}

allow {
  count(input.preview_env.last_5min_trace_ids) > 0
}
