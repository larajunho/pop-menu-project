module Api
  module V1
    class ImportsController < ApplicationController
      def create
        file = params[:file]
        return render json: { status: "fail", logs: ["No file provided"] }, status: :bad_request unless file

        logs = []

        begin
          data = JSON.parse(file.read)

          data["restaurants"].each do |restaurant_data|
            
            restaurant = Restaurant.find_or_create_by!(name: restaurant_data["name"])
            logs << "Restaurant '#{restaurant.name}' processed"

            restaurant_data["menus"].each do |menu_data|
             
              menu = restaurant.menus.find_or_create_by!(name: menu_data["name"])
              logs << " Menu '#{menu.name}' processed for '#{restaurant.name}'"

              
              items = menu_data["menu_items"] || menu_data["dishes"] || []

              items.each do |item_data|
                
                item = MenuItem.find_or_create_by!(
                  name: item_data["name"],
                  restaurant: restaurant
                ) do |mi|
                  mi.price = item_data["price"]
                end

                
                if menu.menu_items.exists?(item.id)
                  logs << "  Skipped duplicate link for '#{item.name}' in menu '#{menu.name}'"
                else
                  menu.menu_items << item
                  logs << "  Linked item '#{item.name}' to menu '#{menu.name}'"
                end
              end
            end
          end

          render json: { status: "success", logs: logs }

        rescue JSON::ParserError
          render json: { status: "fail", logs: ["Invalid JSON format"] }, status: :unprocessable_entity
        rescue => e
          render json: { status: "fail", logs: ["Error: #{e.message}"] }, status: :unprocessable_entity
        end
      end
    end
  end
end





  
