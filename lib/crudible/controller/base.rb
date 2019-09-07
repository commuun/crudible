module Crudible
  module Controller
    module Base
      extend ActiveSupport::Concern

      included do
        helper_method :resource, :resources, :resource_base_path, :order_by
      end

      def create
        if resource.save
          flash[:notice] = I18n.t(
            'crudible.flash.created',
            resource_name: helpers.human_resource_name
          )
          redirect_to after_create_path
        else
          render action: 'new'
        end
      end

      def update
        if resource.save
          flash[:notice] = I18n.t(
            'crudible.flash.updated',
            resource_name: helpers.human_resource_name
          )
          redirect_to after_update_path
        else
          render action: 'edit'
        end
      end

      def destroy
        resource.destroy
        flash[:notice] = I18n.t(
          'crudible.flash.destroyed',
          resource_name: helpers.human_resource_name
        )
        redirect_to after_destroy_path
      end

      protected

      # This is the path that is redirected to after a resource is created.
      # This method can be overridden in your resource's controller.
      def after_create_path
        resource_path
      end

      # This is the path that is redirected to after a resource is updated.
      # This method can be overridden in your resource's controller.
      def after_update_path
        resource_path
      end

      # This is the path that is redirected to after a resource is destroyed.
      # This method can be overridden in your resource's controller.
      def after_destroy_path
        resources_path
      end

      # This method should return the base path that prefixes the resource
      # when redirecting. For example [:admin] if the path is /admin/users
      def resource_base_path
        []
      end

      # Returns the singular resource for the current action
      def resource
        @resource ||= case action_name
                      when 'new', 'create'
                        new_resource
                      when 'update'
                        updated_resource
                      else
                        find_resource
                      end
      end

      # Returns the resources for available to your current controller.
      def resources
        @resources ||= resource_scope.order(order_by)
      end

      # The redirect path to an individual resource's show view
      def resource_path
        resource_base_path + [resource]
      end

      # The redirect path to the resources index view
      def resources_path
        resource_base_path + [helpers.resources_name]
      end

      # Finds the current resource for the show, edit and update actions
      # You can override this in your controller, for example with FriendlyId:
      #
      #   def find_resource
      #     resource_scope.friendly.find(params[:id])
      #   end
      def find_resource
        resource_scope.find(params[:id])
      end

      # Builds a new resource for the new and create actions
      def new_resource
        resource_scope.new(resource_params)
      end

      # Returns the updated resource for the update action
      def updated_resource
        resource = find_resource
        resource.attributes = resource_params
        resource
      end

      # This is the scope within which records are found/built in your
      # controller. For example, `News.published`, `current_user.posts` or
      # simply `Blog.all`
      def resource_scope
        helpers.resource_class.all
      end

      # All controllers that allow new/edit actions should implement this class.
      # It should return the permitted strong params. It should return nil if
      # no params are present.
      def resource_params
        raise NotImplementedError,
              'Each controller should implement resource_params itself'
      end

      # Should return the order by with records should be sorted. Can be a
      # string or an ActiveRecord compatible hash, e.g. { date: :desc }
      #
      # Override this method in your controller to order resources, e.g.
      #   def order_by
      #     { params[:order_by] => params[:order_direction] }
      #   end
      #
      # Can be left as "nil" for no ordering of records.
      def order_by; end
    end
  end
end
