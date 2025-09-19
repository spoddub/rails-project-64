# frozen_string_literal: true

dsn = ENV["SENTRY_DSN"].to_s

if dsn != ""
  Sentry.init do |config|
    config.dsn = dsn
    config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]
    config.enabled_environments = %w[production]
    config.send_default_pii = false
    config.traces_sample_rate = 0.0
    config.profiles_sample_rate = 0.0
  end
end
