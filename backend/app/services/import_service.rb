class ImportService
    def initialize(data)
      @data = data
      @logs = []
    end
  
    def call
      @data["restaurants"].each do |restaurant_data|
        restaurant = Restaurant.find_or_create_by(name: restaurant_data["name"])
  
        restaurant_data["menus"].each do |menu_data|
          menu = restaurant.menus.find_or_create_by(name: menu_data["name"])
  
          items = menu_data["menu_items"] || menu_data["dishes"] || []
  
          items.each do |item_data|
            menu_item = restaurant.menu_items.find_or_create_by!(name: item_data["name"]) # unique per restaurant

            assignment = MenuAssignment.find_or_initialize_by(menu: menu, menu_item: menu_item)
            assignment.price = item_data["price"]

            if assignment.save
              @logs << "Linked item '#{menu_item.name}' to menu '#{menu.name}' with price #{assignment.price}"
            else
              @logs << "Failed to link item '#{menu_item.name}' to menu '#{menu.name}': #{assignment.errors.full_messages.join(", ")}"
            end
          end
        end
      end
  
      @logs
    end
  end
  