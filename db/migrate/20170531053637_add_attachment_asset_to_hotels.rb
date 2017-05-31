class AddAttachmentAssetToHotels < ActiveRecord::Migration
  def self.up
    change_table :hotels do |t|
      t.attachment :asset
    end
  end

  def self.down
    remove_attachment :hotels, :asset
  end
end
