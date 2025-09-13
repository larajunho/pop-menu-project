require "test_helper"

class MenuTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.create(name: "Poppo's Cafe")
    @menu = @restaurant.menus.build(name: "Lunch")
  end

  test "should be valid" do
    assert @menu.valid?
  end

  test "name should be present" do
    @menu.name = ""
    assert_not @menu.valid?
  end

  test "should belong to restaurant" do
    assert_equal @restaurant, @menu.restaurant
  end
end
