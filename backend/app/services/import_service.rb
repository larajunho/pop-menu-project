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
            menu_item = menu.menu_items.find_or_initialize_by(name: item_data["name"])
            menu_item.price = item_data["price"]
  
            if menu_item.save
              @logs << "Saved menu item '#{menu_item.name}' in menu '#{menu.name}'"
            else
              @logs << "Failed to save menu item '#{menu_item.name}' in menu '#{menu.name}': #{menu_item.errors.full_messages.join(", ")}"
            end
          end
        end
      end
  
      @logs
    end
  end
  