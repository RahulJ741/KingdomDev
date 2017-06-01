class AddVideoLinkToHotels < ActiveRecord::Migration[5.0]
  def change
    add_column :hotels, :video_link, :string
  end
end
