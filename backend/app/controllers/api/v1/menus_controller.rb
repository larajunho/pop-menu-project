
module Api
  module V1
    class MenusController < ApplicationController
      before_action :set_restaurant

      def index
        menus = @restaurant.menus.includes(menu_assignments: :menu_item).map do |menu|
          {
            id: menu.id,
            name: menu.name,
            menu_items: menu.menu_assignments.map { |ma| { id: ma.menu_item.id, name: ma.menu_item.name, price: ma.price } }
          }
        end
        render json: menus
      end

      def show
        menu = @restaurant.menus.includes(menu_assignments: :menu_item).find(params[:id])
        payload = {
          id: menu.id,
          name: menu.name,
          menu_items: menu.menu_assignments.map { |ma| { id: ma.menu_item.id, name: ma.menu_item.name, price: ma.price } }
        }
        render json: payload
      end

      private

      def set_restaurant
        @restaurant = Restaurant.find(params[:restaurant_id])
      end
    end
  end
end
