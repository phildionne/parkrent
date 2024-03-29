require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Load environment variables
require 'dotenv'
Dotenv.load(".env.local", ".env.#{Rails.env}")

module ParkRent
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Recursively load models in subdirectories
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.available_locales = [:en, :fr]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :en

    # Protects against typical web attacks
    config.middleware.use Rack::Protection

    # Adds a X-Revision header with the current commit SHA
    config.middleware.use Rack::Revision, default: `git log --pretty=format:'%h' -n 1`

    # Enables compression of http responses
    config.middleware.use Rack::Deflater
  end
end
