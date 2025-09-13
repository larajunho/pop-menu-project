class MenuItem < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_assignments, dependent: :destroy
  has_many :menus, through: :menu_assignments

  validates :name, presence: true, uniqueness: { scope: :restaurant_id }
  validates :price, presence: true
end

