.PHONY: install lint test

install:
	bundle install
migrate:
	bin/rails db:migrate
server:
	bin/rails s
lint:
	bundle exec rubocop -A
slim:
	slim-lint app/views/
test:
	bin/rails test