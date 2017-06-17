class MyPayment < ApplicationRecord
  belongs_to :user
  has_one :my_order
end
