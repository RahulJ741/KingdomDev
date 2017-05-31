class Changefieldtypehotel < ActiveRecord::Migration[5.0]
  def change
    change_column :hotels, :description, :text
  end
end
