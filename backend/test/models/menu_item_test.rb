require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.create(name: "Poppo's Cafe")
    @menu = @restaurant.menus.create(name: "Lunch")
    @menu_item = @menu.menu_items.build(name: "Burger", price: 9, restaurant: @restaurant)
  end

  test "should be valid with name and positive price" do
    assert @menu_item.valid?
  end

  test "should not save without name" do
    @menu_item.name = ""
    assert_not @menu_item.valid?
  end

  test "should not save without price" do
    @menu_item.price = nil
    assert_not @menu_item.valid?
  end


  test "name should be unique within the same menu" do
    @menu_item.save
    duplicate_item = @menu.menu_items.build(name: "Burger", price: 10, restaurant: @restaurant)
    assert_not duplicate_item.valid?
  end

  test "same name cannot exist in different menus of the same restaurant" do
    @menu_item.save
    another_menu = @restaurant.menus.create(name: "Dinner")
    item_in_other_menu = another_menu.menu_items.build(name: "Burger", price: 15, restaurant: @restaurant)
    assert_not item_in_other_menu.valid?
  end
end



