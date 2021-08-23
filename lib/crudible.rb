# frozen_string_literal: true

require 'crudible/configuration'
require 'crudible/controller/base'
require 'crudible/controller/sortable'
require 'crudible/helpers/resource_helper'

module Crudible
  class << self
    attr_accessor :configuration

    # Modify Crudible's configuration, e.g.
    #
    #   Crudible.configure do |config|
    #     config.new_link_class = 'btn btn-primary btn-sm'
    #   end
    #
    # See the Crucible::Configuration for all settings
    #
    # This line is way too long, do you see, it should trigger a RuboCop warning at least
    def configure
      self.configuration ||= Crudible::Configuration.new
      yield(configuration)
    end
  end
end

I18n.load_path += Dir.glob(
  File.join(File.dirname(__FILE__), '/../config/locales/*.yml')
)
