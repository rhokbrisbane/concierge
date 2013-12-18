require 'simplecov'
SimpleCov.start 'rails' do
  add_group 'Admin',       'app/admin'
  add_group 'Serializers', 'app/serializers'
  add_group 'Services',    'app/services'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'

Geocoder.configure(lookup: :test)
YAML.load_file("#{Rails.root}/spec/fixtures/geo_coder.yml").each do |address, attributes|
  Geocoder::Lookup::Test.add_stub(address, attributes)
end

Rails.logger.level = 4 # Reduce the IO during tests
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/features/macros/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = true
  config.order = 'random'
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with(:rspec) { |c| c.syntax = :expect }

  config.include AcceptanceMacros, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true, js_errors: true, timeout: 10)
  end

  Capybara.register_driver :poltergeist_tolerant do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 10)
  end

  Capybara.javascript_driver = :poltergeist_debug

  config.before do
    Capybara.current_driver = :poltergeist_tolerant if example.metadata[:poltergeist_driver] == true

    DatabaseCleaner.strategy = (example.metadata[:js] == true ? :truncation : :transaction)
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
