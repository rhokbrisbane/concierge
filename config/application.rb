require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

Bundler.require(:default, Rails.env)

module Concierge
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Brisbane'
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
  end
end
