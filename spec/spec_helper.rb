require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true, js_errors: true, timeout: 10)
  end

  Capybara.register_driver :poltergeist_tolerant do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 10)
  end

  Capybara.javascript_driver = :poltergeist_debug

  config.before(:each) do
    if example.metadata[:poltergeist_driver] == true
      Capybara.current_driver = :poltergeist_tolerant
    end

    if example.metadata[:js] == true
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end

    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
