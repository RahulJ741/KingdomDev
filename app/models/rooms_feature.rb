class RoomsFeature < ApplicationRecord
  belongs_to :room
  belongs_to :feature
  validates_presence_of :room_id, :feature_id
end
