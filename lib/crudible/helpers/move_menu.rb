module Crudible
  class MoveMenu
    attr_reader :resource, :options, :path, :template

    delegate :t, :link_to, :polymorphic_path, :safe_join, :resource_base_path,
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
          move_link(direction)
        end
      )
    end

    private

    def direction_label(direction)
      t("crudible.links.#{direction}")
    end

    def move_link(direction)
      link_to(
        move_resource_path(direction),
        options.deep_merge(move_options(direction))
      ) do
        direction_label(direction)
      end
    end

    def move_options(direction)
      css_class = Crudible.configuration.move_link_class
      unless enabled?(direction)
        css_class += ' ' + Crudible.configuration.disabled_link_class
      end

      { method: 'PUT', class: css_class }
    end

    def enabled?(direction)
      case direction
      when :higher, :to_top
        !resource.first?
      when :lower, :to_bottom
        !resource.last?
      end
    end

    def move_resource_path(direction)
      polymorphic_path([:move] + resource_path, direction: direction)
    end

    def resource_path
      [path || resource_base_path, resource].flatten.compact
    end
  end
end