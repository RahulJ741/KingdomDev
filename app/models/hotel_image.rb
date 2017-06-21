class HotelImage < ApplicationRecord
  belongs_to :hotel
  has_attached_file :pics, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :pics, content_type: /\Aimage\/.*\z/
end
