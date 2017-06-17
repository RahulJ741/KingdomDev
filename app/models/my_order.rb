class MyOrder < ApplicationRecord
  enum item: [:event, :hotel, :package]
  belongs_to :user
  belongs_to :my_payment
end
