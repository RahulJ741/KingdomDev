class Removefields < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :salt
    remove_column :users, :ip_address
    remove_column :users, :username
  end
end
