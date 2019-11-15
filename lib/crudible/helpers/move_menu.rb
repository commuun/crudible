module Crudible
  class MoveMenu
    attr_reader :resource, :options, :path, :template

    delegate :t, :safe_join, :move_resource_link,
             to: :template

    def initialize(resource, template:, options: {})
      @template = template
      @resource = resource
      @options = options
      @path = @options.delete(:path)
    end

    def render
      return unless Crudible.configuration
                            .auth_callback.call(resource, template, :move)

      safe_join(
        %i[to_top higher lower to_bottom].map do |direction|
          move_resource_link(resource, direction)
        end
      )
    end

    private

    def resource_path
      [path || resource_base_path, resource].flatten.compact
    end
  end
end
