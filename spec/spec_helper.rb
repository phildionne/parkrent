require 'spork'
require 'money-rails/test_helpers'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  if ENV['COVERAGE']
    require 'simplecov'
    SimpleCov.start
  end

  ENV['RACK_ENV'] ||= 'test'

  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'webmock/rspec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

  # All requests to OmniAuth will be short circuited. A request to /auth/provider
  # will redirect immediately to /auth/provider/callback.
  # @see https://github.com/intridea/omniauth/wiki/Integration-Testing
  OmniAuth.config.test_mode = true

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  VCR.configure do |vcr|
    vcr.hook_into :webmock
    vcr.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    vcr.default_cassette_options = { record: :once, re_record_interval: 1.day }

    vcr.around_http_request do |request|

      if request.uri =~ /maps.googleapis.com\/maps\/api\/geocode/
        VCR.use_cassette('geocoding', match_requests_on: [:host, :path], &request)
      end
    end
  end

  RSpec.configure do |config|
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    # Use FactoryGirl syntax methods
    config.include FactoryGirl::Syntax::Methods

    # Use Devise helpers
    config.include Devise::TestHelpers, type: :controller

    # Use MoneyRails helpers
    config.include MoneyRails::TestHelpers

    # Database Cleaner
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :deletion
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    # While using database_cleaner, do not wrap tests in a db transaction
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'

    # Only run a spec when a :focus tag is present
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload

  if ENV['COVERAGE']
    require 'simplecov'
    SimpleCov.start
  end
end
