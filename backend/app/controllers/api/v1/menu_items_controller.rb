
module Api
  module V1
    class MenuItemsController < ApplicationController
      before_action :set_restaurant
      before_action :set_menu

      def index
        items = @menu.menu_assignments.includes(:menu_item).map do |ma|
          { id: ma.menu_item.id, name: ma.menu_item.name, price: ma.price }
        end
        render json: items
      end

      def show
        item = @menu.menu_assignments.includes(:menu_item).find_by!(menu_item_id: params[:id])
        render json: { id: item.menu_item.id, name: item.menu_item.name, price: item.price }
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

