require_relative 'boot'

require "active_record/railtie"
require "action_controller/railtie"

Bundler.require(*Rails.groups)

require 'crudible'

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails.version.split('.')[0, 2].join('.')
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.active_support.deprecation = :stderr
    config.active_support.test_order = :random
    config.cache_classes = true
    config.consider_all_requests_local = true
    config.eager_load = false
    config.encoding = 'utf-8'
    config.secret_key_base = 'SECRET_KEY_BASE'

    root_path = File.dirname(__FILE__) + '/..'

    config.paths['app/controllers'] << "#{root_path}/app/controllers"
    config.paths['app/models'] << "#{root_path}/app/models"
    config.paths['app/views'] << "#{root_path}/app/views"
    config.paths['config/database'] = "#{root_path}/config/database.yml"
    config.paths.add 'config/routes.rb', with: "#{root_path}/config/routes.rb"

    config.i18n.load_path += Dir.glob("#{root_path}/config/locales/*.yml")
  end
end
