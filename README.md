# My Rails Application


[![Ruby CI](https://github.com/PavelAlexee/rails-project-64/actions/workflows/ci.yml/badge.svg)](https://github.com/PavelAlexee/rails-project-64/actions/workflows/ci.yml)
[![Hexlet Check](https://github.com/PavelAlexee/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/PavelAlexee/rails-project-64/actions/workflows/hexlet-check.yml)

## Development

```bash
# Установка зависимостей
bundle install

# Запуск линтеров
bundle exec rubocop
bundle exec slim-lint app/views

# Запуск тестов
bundle exec rails test

# Полная проверка CI
bundle exec rake ci:all
