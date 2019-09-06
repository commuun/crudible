require 'crudible/resource_menu'
require 'crudible/move_menu'

module Crudible
  module Helpers
    # Creates edit/destroy links for the given resource.
    # Any options are passed on to the `link_to` method.
    def resource_menu(resource, options = {})
      Crudible::ResourceMenu.new(
        resource, options: options, template: self
      ).render
    end

    # Creates move up/down/top/bottom links for the given resource to use with
    # the "acts_as_list" gem.
    # Any options are passed on to the `link_to` method.
    def move_menu(resource, options = {})
      Crudible::MoveMenu.new(resource, options: options, template: self).render
    end

    # Returns a link to add a new resource
    def new_resource_link(resource_class, options = {})
      link_to(
        t('crudible.links.new'),
        [:new, resource_base_path, resource_name].flatten,
        options.deep_merge(class: Crudible.configuration.new_link_class)
      )
    end

    # Returns the current resource's system name (e.g. 'news_item')
    def resource_name
      @resource_name ||= controller_name.singularize
    end

    # Returns the current resource's plural system name (e.g. 'news_items')
    def resources_name
      @resources_name ||= controller_name
    end

    # Returns the humanized name of the current resource (e.g. 'News Item')
    def human_resource_name
      @human_resource_name ||= resource_class.model_name.human
    end

    # Returns the plural humanized name of the current resources
    # (e.g. 'News Items')
    def human_resources_name
      @human_resources_name ||= resource_class.model_name.human(count: 2)
    end

    # Return the class for the current resource (e.g. NewsItem)
    def resource_class
      resource_name.classify.constantize
    end

    # Returns the humanized attribute name for the current resource
    def attribute_name(attribute)
      resource_class.human_attribute_name(attribute)
    end
  end
end
