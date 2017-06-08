class AddUniqueIdToHotel < ActiveRecord::Migration[5.0]
  def change
    add_column :hotels, :unique_id, :string
  end
end
