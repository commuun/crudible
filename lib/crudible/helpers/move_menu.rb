module Crudible
  module Helpers
    class MoveMenu
      attr_reader :resource, :options, :path, :template

      delegate :t, :safe_join, :link_to, :polymorphic_path, :resource_base_path,
               :move_resource_class, :move_resource_label,
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
            move_resource_link(direction)
          end
        )
      end

      private

      def move_resource_link(direction)
        link_to(
          move_resource_label(direction),
          move_resource_path(direction),
          move_resource_options(direction)
        )
      end

      def move_resource_path(direction)
        polymorphic_path(
          [:move, resource_base_path, resource].flatten,
          direction: direction
        )
      end

      def move_resource_options(direction)
        css_class = move_resource_class(direction)
        css_class += ' disabled' if move_link_disabled?(direction)
        { method: 'PUT', class:  css_class }
      end

      def move_link_disabled?(direction)
        case direction
        when :higher, :to_top
          resource.first?
        when :lower, :to_bottom
          resource.last?
        end
      end
    end
  end
end
