class Menu < ApplicationRecord
    belongs_to :restaurant
    has_many :menu_assignments, dependent: :destroy
    has_many :menu_items, through: :menu_assignments
    validates :name, presence: true

    def items_with_prices
      menu_assignments.includes(:menu_item).map { |ma| { id: ma.menu_item.id, name: ma.menu_item.name, price: ma.price } }
    end
  end
