class RemovePriceFromMenuItems < ActiveRecord::Migration[8.0]
  def up
    remove_column :menu_items, :price, :decimal
  end

  def down
    add_column :menu_items, :price, :decimal
  end
end
