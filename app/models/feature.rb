class Feature < ApplicationRecord
  # belongs_to :room_feature
  has_many :rooms
  # has_many :rooms_features
  # has_many :rooms ,:through => :rooms_features
  has_attached_file :pics, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :pics, content_type: /\Aimage\/.*\z/
end
