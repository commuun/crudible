require 'crudible/helpers/resource_menu'
require 'crudible/helpers/move_menu'

module Crudible
  module Helpers
    module ResourceHelper
      # Creates edit/destroy links for the given resource.
      #
      # The options hash currently only has one important key: `path`, which
      # can be used to add a namespace to the resource's path. For example, if
      # your route is in the `:admin` namespace, you could do this:
      #
      #     resource_menu(user, path: [:admin])
      #
      # Note that if no path is supplied, the resource_base_path as defined in
      # the controller is used.
      def resource_menu(resource, options = {})
        Crudible::ResourceMenu.new(
          resource, options: options, template: self
        ).render
      end

      # Creates move higher/lower/top/bottom links for the given resource to use
      # with the acts_as_list gem.
      #
      # The options hash currently only has one important key: `path`, which can
      # be used to add a namespace to the resource's path. For example, if your
      # route is in the `:admin` namespace, you could do this:
      #
      # Note that if no path is supplied, the resource_base_path as defined in
      # the controller is used.
      #
      #     resource_menu(user, path: [:admin])
      def move_menu(resource, options = {})
        Crudible::MoveMenu
          .new(resource, options: options, template: self)
          .render
      end

      # Returns a link to add a new resource. If no target is given, uses
      # the current controller's resource_name as a target. e.g.
      #
      #     new_resource_link :blog
      #
      #  is equivalent to
      #
      #     new_resource_link
      #
      #  assuming the current controller is the BlogsController
      def new_resource_link(target = nil, options = {})
        link_to(
          t('crudible.links.new'),
          [:new, resource_base_path, target || resource_name].flatten,
          options.deep_merge(class: Crudible.configuration.new_link_class)
        )
      end

      # This is the method used by the resource_menu helper to render the actual
      # links. These can be overridden to include your own styles, icons or
      # translations.
      def edit_resource_link(resource_path)
        link_to(t('crudible.links.edit'), resource_path,
                class: Crudible.configuration.edit_link_class)
      end

      # This is the method used by the resource_menu helper to render the actual
      # links. These can be overridden to include your own styles, icons or
      # translations.
      def destroy_resource_link(resource_path)
        link_to(
          t('crudible.links.destroy'),
          resource_path, destroy_resource_link_options(resource_path.last)
        )
      end

      def destroy_resource_link_options(resource)
        name = resource.class.model_name.human.downcase
        {
          class: Crudible.configuration.destroy_link_class,
          method: :delete, data: {
            confirm: t(
              'crudible.confirm.delete',
              resource_name: name
            )
          }
        }
      end

      # Returns the humanized name of the current resource (e.g. News Item)
      def human_resource_name
        @human_resource_name ||= resource_class.model_name.human
      end

      # Returns the plural humanized name of the current resources
      # (e.g. News Items)
      def human_resources_name
        @human_resources_name ||= resource_class.model_name.human(count: 2)
      end

      # Returns the humanized attribute name for the current resource
      def attribute_name(attribute)
        resource_class.human_attribute_name(attribute)
      end
    end
  end
end

ActionView::Base.send(:include, Crudible::Helpers::ResourceHelper)
