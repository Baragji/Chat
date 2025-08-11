package ci.finops

default allow := false

forecast_dollars := input.focus.weekly_forecast_usd
target := 300
ceiling := 500

deny[msg] {
  forecast_dollars > ceiling
  msg := sprintf("Budget ceiling exceeded: $%.2f > $%d", [forecast_dollars, ceiling])
}

warn[msg] {
  forecast_dollars > target * 1.15
  msg := sprintf("Forecast > target+15%%: $%.2f > $%.2f (add optimization plan)", [forecast_dollars, target*1.15])
}

allow {
  not deny[_]
}
