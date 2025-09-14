class AddPriceToMenuAssignments < ActiveRecord::Migration[8.0]
  def up
    add_column :menu_assignments, :price, :decimal

    # Backfill prices
    say_with_time "Backfilling menu_assignments.price from menu_items.price" do
      case ActiveRecord::Base.connection.adapter_name.downcase.to_sym
      when :sqlite
        execute <<~SQL
          UPDATE menu_assignments
          SET price = (
            SELECT price
            FROM menu_items
            WHERE menu_items.id = menu_assignments.menu_item_id
          )
          WHERE EXISTS (
            SELECT 1
            FROM menu_items
            WHERE menu_items.id = menu_assignments.menu_item_id
              AND menu_items.price IS NOT NULL
          )
        SQL
      else
        execute <<~SQL
          UPDATE menu_assignments ma
          SET price = mi.price
          FROM menu_items mi
          WHERE ma.menu_item_id = mi.id AND mi.price IS NOT NULL
        SQL
      end
    end
  end

  def down
    remove_column :menu_assignments, :price
  end
end
