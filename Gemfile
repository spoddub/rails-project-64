source "https://rubygems.org"

ruby file: ".ruby-version"

# Rails
gem "rails", "~> 8.0.2"

# HTTP/web
gem "puma", ">= 5.0"
gem "sprockets-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

# Slim
gem "slim-rails"
gem "slim"

group :development, :test do
  # database for dev/test
  gem "sqlite3", ">= 1.4"

  # checks
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rails", require: false
  gem "slim_lint", require: false

  # test data
  gem "faker"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  # Power Assert for minitest
  gem "minitest-power_assert"
end

group :production do
  gem "pg"
  # Sentry
  gem "sentry-rails"
  gem "sentry-ruby"
end
