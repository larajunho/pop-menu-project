require "test_helper"

class MenuTest < ActiveSupport::TestCase
  test "should not save menu without name" do
    menu = Menu.new
    assert_not menu.save
  end
end
