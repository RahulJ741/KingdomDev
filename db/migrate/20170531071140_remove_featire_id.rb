class RemoveFeatireId < ActiveRecord::Migration[5.0]
  def change
    remove_column :features, :room_id
  end
end
