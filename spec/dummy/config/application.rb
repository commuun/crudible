require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'crudible'

module Dummy
  class Application < Rails::Application
    config.load_defaults 5.2
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_mailer.default_url_options = { host: 'dummy.example.com' }
    config.action_mailer.delivery_method = :test
    config.active_support.deprecation = :stderr
    config.active_support.test_order = :random
    config.cache_classes = true
    config.consider_all_requests_local = true
    config.eager_load = false
    config.encoding = 'utf-8'

    config.active_job.queue_adapter = :inline

    root_path = File.dirname(__FILE__) + '/..'

    config.paths['app/controllers'] << "#{root_path}/app/controllers"
    config.paths['app/models'] << "#{root_path}/app/models"
    config.paths['app/views'] << "#{root_path}/app/views"
    config.paths['config/database'] = "#{root_path}/config/database.yml"
    config.paths.add 'config/routes.rb', with: "#{root_path}/config/routes.rb"

    config.i18n.load_path += Dir.glob("#{root_path}/config/locales/*.yml")
  end
end
