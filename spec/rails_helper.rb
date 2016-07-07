# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

# Add additional requires below this line. Rails is not loaded until this point!
require 'factory_girl_rails'
require 'support/factory_girl'
require 'spec_helper'
require 'simplecov'
require 'rspec/rails'
require 'rspec/retry'
require 'capybara/rails'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
SimpleCov.start 'rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.order = :random

  # make output colorful
  # config.color_enabled = true

  config.example_status_persistence_file_path = "spec/tmp/examples.txt"

  # config.include Capybara::DSL

  # Capybara.javascript_driver = :webkit

  # Capybara::Webkit.configure do |cconfig|
  #   # Silently return an empty 200 response for any requests to unknown URLs.
  #   cconfig.block_unknown_urls
  #
  #   # Timeout if requests take longer than 5 seconds
  #   cconfig.timeout = 5
  #
  #   # Don't raise errors when SSL certificates can't be validated
  #   cconfig.ignore_ssl_errors
  #   # Don't load images
  #   cconfig.skip_image_loading
  # end

  # show retry status in spec process
  # config.verbose_retry = true
  # # show exception that triggers a retry if verbose_retry is set to true
  # config.display_try_failure_messages = true
  #
  # # run retry only on features
  # config.around :each, :js do |ex|
  #  ex.run_with_retry retry: 2
  # end

  # @headless = Headless.new(display: 100, reuse: true, destroy_at_exit: false).start

  # DatabaseCleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
