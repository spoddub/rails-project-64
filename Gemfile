# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.2.2'

# Rails
gem 'rails', '~> 7.2.2', '>= 7.2.2.2'

# HTTP/web
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'puma', '>= 5.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

# Slim
gem 'slim-rails'

group :development, :test do
  # database for dev/test
  gem 'sqlite3', '>= 1.4'

  # checks
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rails-omakase', require: false
  gem 'slim_lint', require: false

  # test data
  gem 'faker'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  # Power Assert for minitest
  gem 'minitest-power_assert'
end

group :production do
  gem 'pg'
  # Sentry
  gem 'sentry-rails'
  gem 'sentry-ruby'
end

gem 'devise'
gem 'simple_form'
gem 'ancestry', '~> 4.3'
