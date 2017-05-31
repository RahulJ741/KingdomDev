class CreateRoomsFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms_features do |t|
      t.column :room_id, :integer
      t.column :feature_id, :integer
      t.timestamps
    end
  end
end
