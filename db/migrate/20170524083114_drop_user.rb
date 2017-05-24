class DropUser < ActiveRecord::Migration[5.0]
  def change
 
  	remove_column :users, :remember_code, :string
  	remove_column :users, :forgotten_password_code, :string
  	remove_column :users, :forgotten_password_time, :integer
  	remove_column :users, :last_login, :integer
  	remove_column :users, :company, :string
  end
end
