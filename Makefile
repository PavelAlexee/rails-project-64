setup:
	bundle install
	yarn install
	rails db:create db:migrate db:seed

start:
	bin/rails s

test:
	bundle exec rails test

test_controllers:
	bundle exec rails test test/controllers

test_models:
	bundle exec rails test test/models

test_integration:
	bundle exec rails test test/integration
		
lint-rubocop:
	bundle exec rubocop

lint-slim:
	bundle exec slim-lint app/views		

lint-rubocop-fix:
	bundle exec rubocop -A
