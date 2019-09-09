require 'rails/generators/base'
require 'rails/generators/active_record'

module Crudible
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def create_crudible_initializer
        copy_file 'crudible.rb', 'config/initializers/crudible.rb'
      end

      def display_readme_in_terminal
        readme 'README.md'
      end
    end
  end
end
