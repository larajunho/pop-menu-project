module Api
  module V1
    class ImportsController < ApplicationController
      def create
        logs = []
        file = params[:file]

        unless file
          return render json: { status: "fail", logs: ["No file provided"] }, status: :bad_request
        end

        begin
          data = JSON.parse(file.read)

          data["restaurants"].each do |restaurant_data|
            restaurant = Restaurant.find_or_create_by!(name: restaurant_data["name"])

            restaurant_data["menus"].each do |menu_data|
              menu = restaurant.menus.find_or_create_by!(name: menu_data["name"])

              items = menu_data["menu_items"] || menu_data["dishes"] || []
              items.each do |item_data|
                item = restaurant.menu_items.find_or_create_by!(
                  name: item_data["name"],
                  price: item_data["price"]
                )

                if menu.menu_items.exists?(item.id)
                  logs << "Skipped duplicate link for '#{item.name}' in '#{menu.name}'"
                else
                  menu.menu_items << item
                  logs << "Linked menu item '#{item.name}' to menu '#{menu.name}'"
                end
              end
            end
          end

          render json: { status: "success", logs: logs }
        rescue => e
          render json: { status: "fail", logs: ["Error: #{e.message}"] }, status: :unprocessable_entity
        end
      end
    end
  end
end


  
