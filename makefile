test:
	bundle exec rails test

test_controllers:
	bundle exec rails test test/controllers

test_models:
	bundle exec rails test test/models

test_integration:
	bundle exec rails test test/integration

rubocop:
	bundle exec rubocop

rubocop_fix:
	bundle exec rubocop -A
		