module Crudible
  class MoveMenu
    attr_reader :resource, :options, :template

    delegate :t, :link_to, :polymorphic_path, :safe_join, to: :template

    def initialize(resource, template:, options: {})
      @template = template
      @resource = resource
      @options = options
    end

    def render
      if Crudible.configuration.auth_callback.call(resource, template, :move)
        safe_join(
          %i[top up down bottom].map do |direction|
            move_link(direction)
          end
        )
      end
    end

    private

    def described_class
      resource.class
    end

    def described_class_name
      described_class.model_name.human
    end

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
      when :up, :top
        !resource.first?
      when :down, :bottom
        !resource.last?
      end
    end

    def move_resource_path(direction)
      polymorphic_path([:move] + resource_path, direction: direction)
    end

    def resource_path
      [options[:path], resource].flatten.compact
    end
  end
end
