class ShoppingCart < ApplicationRecord

  belongs_to :room
  belongs_to :user
  # has_many :rooms
end
