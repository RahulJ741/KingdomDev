class PendingOrder < ApplicationRecord
  enum item: [:event, :hotel, :package]
  belongs_to :user
end
