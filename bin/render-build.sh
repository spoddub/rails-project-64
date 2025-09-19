#!/usr/bin/env bash
set -o errexit

bundle install

npm ci --include=dev || npm install

bundle exec rails assets:precompile

bundle exec rails db:migrate
