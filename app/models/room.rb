class Room < ApplicationRecord
  belongs_to :hotel
  has_many :rooms_features, dependent: :destroy
  has_many :features ,:through => :rooms_features


end
