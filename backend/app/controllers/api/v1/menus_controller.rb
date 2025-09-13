
module Api
  module V1
    class MenusController < ApplicationController
      before_action :set_restaurant

      def index
        render json: @restaurant.menus.as_json(include: :menu_items)
      end

      def show
        menu = @restaurant.menus.find(params[:id])
        render json: menu.as_json(include: :menu_items)
      end

      private

      def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
      end
    end
  end
end
