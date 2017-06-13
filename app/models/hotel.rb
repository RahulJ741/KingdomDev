class Hotel < ApplicationRecord
  has_many :hotel_images
  has_many :rooms
  has_attached_file :pics, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :pics, content_type: /\Aimage\/.*\z/
  has_one :hotel_shopping_cart

  scope :star_rating, -> (star_rating) { where star_rating: star_rating }

end
