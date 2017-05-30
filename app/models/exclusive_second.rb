class ExclusiveSecond < ApplicationRecord
  has_attached_file :pics, styles: { medium: "300x300>", thumb: "100x100>",:small=>"50*70" }
  validates_attachment_content_type :pics, content_type: /\Aimage\/.*\z/
end
