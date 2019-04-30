# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module BlogCreatorApi
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.system_tests = nil

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    config.action_cable.mount_path = '/events'
  end
end
