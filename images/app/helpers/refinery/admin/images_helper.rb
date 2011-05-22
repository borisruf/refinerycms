module Refinery
  module Admin
    module ImagesHelper

      def image_views
        ::Refinery::RefinerySetting.find_or_set(:image_views, [:grid, :list])
      end

      def current_image_view
        ::Refinery::RefinerySetting.find_or_set(:preferred_image_view, :grid)
      end

      def other_image_views
        image_views.reject {|image_view| image_view.to_s == current_image_view.to_s }
      end

      def images_paginator(collection, dialog = false)
        will_paginate collection, :renderer => Refinery::LinkRenderer
      end

      def change_list_mode_if_specified
        if action_name == 'index' and params[:view].present? and image_views.include?(params[:view].to_sym)
          ::Refinery::RefinerySetting.set(:preferred_image_view, params[:view])
        end
      end

    end
  end
end