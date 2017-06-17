class CreateMyPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :my_payments do |t|
      t.column :user_id, :integer
      t.column :payment_id, :string
      t.column :total, :float
      t.column :date, :date
      t.timestamps
    end
  end
end
