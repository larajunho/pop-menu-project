module Api
    module V1
      class RestaurantsController < ApplicationController
        def index
          restaurants = Restaurant.includes(menus: { menu_assignments: :menu_item }).all
          payload = restaurants.map do |r|
            {
              id: r.id,
              name: r.name,
              menus: r.menus.map do |m|
                {
                  id: m.id,
                  name: m.name,
                  menu_items: m.menu_assignments.map { |ma| { id: ma.menu_item.id, name: ma.menu_item.name, price: ma.price } }
                }
              end
            }
          end
          render json: payload
        end
  
        def show
          restaurant = Restaurant.includes(menus: { menu_assignments: :menu_item }).find(params[:id])
          payload = {
            id: restaurant.id,
            name: restaurant.name,
            menus: restaurant.menus.map do |m|
              {
                id: m.id,
                name: m.name,
                menu_items: m.menu_assignments.map { |ma| { id: ma.menu_item.id, name: ma.menu_item.name, price: ma.price } }
              }
            end
          }
          render json: payload
        end
      end
    end
  end