class RemoveNameFiled < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :name, :string 
  end
end
