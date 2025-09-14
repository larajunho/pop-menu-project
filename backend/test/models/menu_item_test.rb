require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.create(name: "Poppo's Cafe")
    @menu = @restaurant.menus.create(name: "Lunch")
    @menu_item = @restaurant.menu_items.build(name: "Burger")
  end

  test "should be valid with name" do
    assert @menu_item.valid?
  end

  test "should not save without name" do
    @menu_item.name = ""
    assert_not @menu_item.valid?
  end

  # Price moved to MenuAssignment; MenuItem no longer validates price


  test "name should be unique within the same restaurant" do
    @menu_item.save
    duplicate_item = @restaurant.menu_items.build(name: "Burger")
    assert_not duplicate_item.valid?
  end

  test "menu assignment holds price per menu" do
    @menu_item.save!
    ma1 = MenuAssignment.create!(menu: @menu, menu_item: @menu_item, price: 9)
    dinner = @restaurant.menus.create!(name: "Dinner")
    ma2 = MenuAssignment.create!(menu: dinner, menu_item: @menu_item, price: 15)
    assert_equal 9, ma1.price
    assert_equal 15, ma2.price
  end
end



