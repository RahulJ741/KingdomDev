class MyPayment < ApplicationRecord
  belongs_to :user
  has_many :my_orders
end
