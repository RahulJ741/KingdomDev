class AddpapercliptoHotels < ActiveRecord::Migration[5.0]
  def change
    add_attachment :hotels, :pics
  end
end
