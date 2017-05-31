class HotelImage < ApplicationRecord
  belongs_to :hotel
  has_attached_file :pics, styles: { medium: "300x300>", thumb: "100x100>" }
  has_many :pics, :dependent => :destroy
  validates_attachment_content_type :pics, content_type: /\Aimage\/.*\z/
  attr_accessor :delete_pics
  before_validation { self.pics.clear if self.delete_pics == '1' }
end
