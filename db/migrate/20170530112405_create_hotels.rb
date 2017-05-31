class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.column :name, :string, :null => false
      t.column :address, :string, :null => false
      t.column :star_rating, :integer
      t.column :description, :string
      t.timestamps
    end
  end
end
