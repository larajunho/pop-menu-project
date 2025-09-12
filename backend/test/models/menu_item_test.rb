require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  test "should not save menu_item without name or price" do
    menu = Menu.create(name: "Lunch")
    item = MenuItem.new(menu: menu)
    assert_not item.save

    item.name = "Burger"
    item.price = -5
    assert_not item.save
  end
end
