class Makepassnulltrue < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :password, :string, :null => true
  end
end
