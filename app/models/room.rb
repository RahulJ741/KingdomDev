class Room < ApplicationRecord
  belongs_to :hotel
  has_many :rooms_features, dependent: :destroy
  has_many :features ,:through => :rooms_features
  has_one :shopping_cart
  # has_one :user,through: :shopping_cart
  # belongs_to :shopping_cart
end
