require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.new(name: "Poppo's Cafe")
  end

  test "should be valid" do
    assert @restaurant.valid?
  end

  test "name should be present" do
    @restaurant.name = ""
    assert_not @restaurant.valid?
  end

  test "should have many menus" do
    @restaurant.save
    menu1 = @restaurant.menus.create(name: "Lunch")
    menu2 = @restaurant.menus.create(name: "Dinner")
    assert_equal 2, @restaurant.menus.count
  end
end
