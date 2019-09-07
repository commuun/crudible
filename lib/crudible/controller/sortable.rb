module Crudible
  module Controller
    module Sortable
      extend ActiveSupport::Concern

      def move
        resource.public_send("move_#{direction}")

        flash[:notice] = I18n.t(
          'crudible.flash.moved',
          resource_name: helpers.human_resource_name
        )

        redirect_to after_move_path
      end

      protected

      def direction
        case params[:direction]
        when 'up'
          :higher
        when 'down'
          :lower
        when 'top'
          :to_top
        when 'bottom'
          :to_bottom
        end
      end

      # This is the path that is redirected to after a resource is moveed.
      # This method can be overridden in your resource's controller.
      def after_move_path
        resources_path
      end
    end
  end
end
