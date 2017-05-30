class CreateExclusives < ActiveRecord::Migration[5.0]
  def change
    create_table :exclusives do |t|
      t.column :name, :string, :null => false
      t.column :is_active, :boolean
      t.attachment :pics
      t.timestamps
    end
  end
end
