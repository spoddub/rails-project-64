#!/usr/bin/env bash
set -o errexit

bundle install

if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

bundle exec rails assets:precompile
bundle exec rails db:migrate
