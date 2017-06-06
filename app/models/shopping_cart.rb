class ShoppingCart < ApplicationRecord

  belongs_to :room
  belongs_to :user
  # has_and_belongs_to_many :rooms 
  # has_many :rooms
end
