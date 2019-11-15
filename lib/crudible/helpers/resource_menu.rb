module Crudible
  module Helpers
    class ResourceMenu
      attr_reader :resource, :options, :path, :template

      delegate :t, :link_to, :safe_join, :resource_base_path,
               :edit_resource_label, :edit_resource_class,
               :destroy_resource_label, :destroy_resource_class,
               to: :template

      def initialize(resource, template:, options: {})
        @resource = resource
        @template = template
        @options = options
        @path = @options.delete(:path)
      end

      def render
        safe_join(
          [destroy_link, edit_link].compact
        )
      end

      private

      def edit_link
        return unless Crudible.configuration
                              .auth_callback.call(resource, template, :edit)

        link_to(
          edit_resource_label,
          [:edit, path || resource_base_path, resource].flatten,
          class: edit_resource_class
        )
      end

      def destroy_link
        return unless Crudible.configuration
                              .auth_callback.call(resource, template, :destroy)

        link_to(
          t('crudible.links.destroy'),
          [path || resource_base_path, resource].flatten,
          destroy_resource_link_options(resource)
        )
      end

      def destroy_resource_link_options(resource)
        name = resource.class.model_name.human.downcase

        {
          class: destroy_resource_class,
          method: :delete, data: {
            confirm: t(
              'crudible.confirm.delete',
              resource_name: name
            )
          }
        }
      end
    end
  end
end
