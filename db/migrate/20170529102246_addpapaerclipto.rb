class Addpapaerclipto < ActiveRecord::Migration[5.0]
  def change
    add_attachment :countries, :pics 
  end
end
