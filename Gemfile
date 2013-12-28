source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.0.2'
gem 'thin'
gem 'foreman'

# Use PostgreSQL
gem 'pg'

# Abort requests that are taking too long
gem 'rack-timeout'
# Adds a revision number to the request's header
gem 'rack-revision'
# Protects against typical web attacks
gem 'rack-protection'
# Faster string escaping
gem 'escape_utils'

# Use Devise to handle users
gem 'devise'
gem 'devise-i18n'

# Authorization logic
gem 'authority'

# Soft destroys
gem 'paranoia', '~> 2.0'

# Comments for models
gem 'parole'

# Geocoding and reverse geocoding
gem 'geocoder'

# Handle time related recurrence rules
gem 'ice_cube'

# Static pages
gem 'high_voltage'

# View helpers
gem 'flutie'

# Use presenters
gem 'bourgeois'

# Permalinks and slugs
gem 'friendly_id', github: 'FriendlyId/friendly_id'

# Better forms
gem 'simple_form', github: 'plataformatec/simple_form'

# Pagination
gem 'will_paginate'

gem 'date_validator'

# Money integration
gem 'money-rails'

# Multi-model objects
gem 'associates', path: '/Users/pdionne/Dev/associates'

# Object attributes
gem 'virtus'

# Payment processor
gem 'omniauth-stripe-connect'
gem 'stripe'


gem 'less-rails'
gem 'therubyracer', platforms: :ruby
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'sprockets_better_errors'

gem 'jquery-rails'
gem 'turbolinks'


group :development, :test do
  # Loads environment variables from .env
  gem 'dotenv-rails'

  # Use debugger to debug, duh.
  gem 'debugger'

  # Use Factories instead of fixtures
  gem 'factory_girl_rails', '~> 4.0'

  # Pretty print
  gem 'awesome_print'

  # Use FFaker for (faster) random data
  gem 'ffaker'
end


group :development do
  # Remove asset lines from STDOUT
  gem 'quiet_assets'

  # Use pry as default rails console
  gem 'pry-rails'

  # Use better_errors for nicer rails error page
  gem 'better_errors'

  # Use binding_of_caller for rails live web debugging with better_errors
  gem 'binding_of_caller'
end


group :test do
  # Rspec
  gem 'rspec-rails'

  # Running spork with rails
  gem 'spork-rails'

  # Automatically start/reload RSpec Spork server
  gem 'guard-spork'

  # Automatically run specs
  gem 'guard-rspec'

  # Scans application for vulnerabilities
  gem 'guard-brakeman'

  # Cleanup database during tests
  gem 'database_cleaner', github: 'bmabey/database_cleaner'

  # Testing matchers
  gem 'shoulda-matchers'

  # Rspec formatter
  gem 'fivemat'

  # Stubbing and setting expectations on HTTP requests
  gem 'webmock'

  # Records tests HTTP interactions and replay
  gem 'vcr'

  # Code coverage
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
