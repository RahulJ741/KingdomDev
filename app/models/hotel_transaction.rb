class HotelTransaction < ApplicationRecord

  belongs_to :user
  belongs_to :hotel
  # has_and_belongs_to_many :rooms
  # has_many :rooms



  # scope :from_date, ->
  # scope :status, -> (status) { where status: status }
end
