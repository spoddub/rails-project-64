install:
	bundle install
migrate:
	bin/rails db:migrate
server:
	bin/rails s