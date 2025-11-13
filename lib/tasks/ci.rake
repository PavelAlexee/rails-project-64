namespace :ci do
  desc 'Run all CI checks (lint + test)'
  task all: :environment do
    puts '=== Running CI Checks ==='

    puts '1. Running Rubocop...'
    Rake::Task['ci:lint'].invoke

    puts '2. Running tests...'
    Rake::Task['ci:test'].invoke

    puts '✅ All CI checks passed!'
  end

  desc 'Run linting'
  task lint: :environment do
    puts 'Running Rubocop...'
    sh 'bundle exec rubocop'

    puts 'Running Rubocop auto-correct...'
    sh 'bundle exec rubocop -a '

    puts 'Running Slim-Lint...'
    sh 'bundle exec slim-lint app/views'

    puts '✅ Linting passed!'
  end

  desc 'Run tests'
  task test: :environment do
    sh 'bundle exec rails test'
    puts '✅ Tests passed!'
  end
end
