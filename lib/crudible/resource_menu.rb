module Crudible
  # This class renders the edit/destroy links for a resource. Used by the
  # Crudible::Helpers module.
  class ResourceMenu
    attr_reader :resource, :options, :template

    delegate :t, :link_to, :safe_join, to: :template

    def initialize(resource, template:, options: {})
      @resource = resource
      @template = template
      @options = options
    end

    def render
      links = []

      links << destroy_link
      links << edit_link

      safe_join(links)
    end

    private

    def described_class
      resource.class
    end

    def described_class_name
      described_class.model_name.human
    end

    def edit_link
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
      [options[:path], resource].flatten.compact
    end
  end
end
