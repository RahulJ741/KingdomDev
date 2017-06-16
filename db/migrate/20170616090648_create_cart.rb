class CreateCart < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.column :item, :integer
      t.column :item_id, :integer
      t.column :item_uid, :string
      t.column :item_cat_code, :string
      t.column :quantity, :integer
      t.timestamps
    end
  end
end
