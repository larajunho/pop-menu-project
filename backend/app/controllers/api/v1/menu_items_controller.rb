
module Api
  module V1
    class MenuItemsController < ApplicationController
      before_action :set_restaurant
      before_action :set_menu

      def index
        render json: @menu.menu_items
      end

      def show
        item = @menu.menu_items.find(params[:id])
        render json: item
      end

      private

      def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
      end

      def set_menu
        @menu = @restaurant.menus.find(params[:menu_id])
      end
    end
  end
end

