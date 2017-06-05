class ShoppingCart < ApplicationRecord
  has_many :rooms
  belongs_to :user
end
