class CreateFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :features do |t|
      t.column :room_id, :integer, :null => false
      t.column :name, :string, :null => false
      t.attachment :pics
      t.column :description, :string

      t.timestamps
    end
  end
end
