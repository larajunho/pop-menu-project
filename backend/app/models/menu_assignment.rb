class MenuAssignment < ApplicationRecord
    belongs_to :menu
    belongs_to :menu_item
  
  validates :menu_id, uniqueness: { scope: :menu_item_id }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

    def effective_price
      price
    end
  end