module Crudible
  # This class renders the edit/destroy links for a resource. Used by the
  # Crudible::Helpers module.
  class ResourceMenu
    attr_reader :resource, :options, :path, :template

    delegate :t, :link_to, :safe_join, :resource_base_path, to: :template

    def initialize(resource, template:, options: {})
      @resource = resource
      @template = template
      @options = options
      @path = @options.delete(:path)
    end

    def render
      safe_join([
        destroy_link,
        edit_link
      ].compact)
    end

    private

    def described_class
      resource.class
    end

    def described_class_name
      described_class.model_name.human
    end

    def edit_link
      return unless Crudible.configuration
                            .auth_callback.call(resource, template, :edit)

      link_to(
        t('crudible.links.edit'),
        [:edit] + resource_path,
        options.deep_merge(edit_options)
      )
    end

    def edit_options
      { class: Crudible.configuration.edit_link_class }
    end

    def destroy_link
      return unless Crudible.configuration
                            .auth_callback.call(resource, template, :destroy)

      link_to(
        t('crudible.links.destroy'),
        resource_path,
        options.deep_merge(destroy_options)
      )
    end

    def destroy_options
      {
        class: Crudible.configuration.destroy_link_class,
        method: :delete, data: {
          confirm: t(
            'crudible.confirm.delete',
            resource_name: described_class_name
          )
        }
      }
    end

    def resource_path
      [path || resource_base_path, resource].flatten.compact
    end
  end
end
