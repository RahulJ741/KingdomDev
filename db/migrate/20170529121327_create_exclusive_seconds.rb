class CreateExclusiveSeconds < ActiveRecord::Migration[5.0]
  def change
    create_table :exclusive_seconds do |t|
      t.column :country, :string, :null => false
      t.column :is_active, :boolean
      t.attachment :pics
      t.column :order_by, :integer
      t.timestamps
    end
  end
end
