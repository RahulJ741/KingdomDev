class DropTableRoomsFeatures < ActiveRecord::Migration[5.0]
  def change
    drop_table :rooms_features
  end
end
