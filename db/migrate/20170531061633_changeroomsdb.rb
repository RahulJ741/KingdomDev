class Changeroomsdb < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :description, :text
    change_column :rooms, :details, :text
    change_column :rooms, :breakfast, :boolean
  end
end
