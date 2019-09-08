module Crudible
  module Controller
    # If your resource `acts_as_list`, you can include this module in addition
    # to the Crudible base controller to make a move action available.
    # Use together with the `move_menu` helper to generate the relevant links.
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
        params[:direction] if available_directions.include?(params[:direction])
      end

      def available_directions
        %w[higher lower to_top to_bottom]
      end

      # This is the path that is redirected to after a resource is moveed.
      # This method can be overridden in your resource's controller.
      def after_move_path
        resources_path
      end
    end
  end
end
