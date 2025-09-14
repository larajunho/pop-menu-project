require "test_helper"

class MenuAssignmentTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.create!(name: "Poppo's Cafe")
    @lunch = @restaurant.menus.create!(name: "Lunch")
    @item = @restaurant.menu_items.create!(name: "Burger")
  end

  test "requires non-negative price if provided" do
    ma = MenuAssignment.new(menu: @lunch, menu_item: @item, price: -1)
    assert_not ma.valid?
    ma.price = 0
    assert ma.valid?
  end

  test "unique menu/menu_item pair" do
    MenuAssignment.create!(menu: @lunch, menu_item: @item, price: 9)
    dupe = MenuAssignment.new(menu: @lunch, menu_item: @item, price: 10)
    assert_not dupe.valid?
  end
end
