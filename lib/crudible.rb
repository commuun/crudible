# frozen_string_literal: true

require 'crudible/configuration'
require 'crudible/controller'
require 'crudible/helpers'

module Crudible
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Crudible::Configuration.new
      yield(configuration)
    end
  end
end

I18n.load_path += Dir.glob(
  File.join(File.dirname(__FILE__), '/../config/locales/*.yml')
)
