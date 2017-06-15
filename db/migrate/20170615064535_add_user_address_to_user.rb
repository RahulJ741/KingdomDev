class AddUserAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :middle_name, :string
    add_column :users, :address, :text
    add_column :users, :city, :text
    add_column :users, :state, :string
    add_column :users, :post_code, :integer
    add_column :users, :country, :string
  end
end
