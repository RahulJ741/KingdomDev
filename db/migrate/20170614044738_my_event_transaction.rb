class MyEventTransaction < ActiveRecord::Migration[5.0]
  def change
  	create_table :event_transactions do |t|
      t.column :user_id, :integer, :null => false
      t.column :event_id, :string
      t.column :event_cat, :string
      t.column :event_date, :datetime
      t.column :rate, :integer
      t.column :status, :string
      t.timestamps
    end
  end
end
