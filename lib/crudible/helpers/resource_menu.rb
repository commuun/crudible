module Crudible
  # This class renders the edit/destroy links for a resource. Used by the
  # Crudible::Helpers module.
  class ResourceMenu
    attr_reader :resource, :options, :path, :template

    delegate :t, :link_to, :safe_join, :resource_base_path,
             :edit_resource_link, :destroy_resource_link, to: :template

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

    def edit_link
      return unless Crudible.configuration
                            .auth_callback.call(resource, template, :edit)

      edit_resource_link(resource)
    end

    def destroy_link
      return unless Crudible.configuration
                            .auth_callback.call(resource, template, :destroy)

      destroy_resource_link(resource)
    end
  end
end
