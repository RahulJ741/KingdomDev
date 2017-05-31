class Changebd < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :hotels, :asset
    
  end
end
