class CreateStaticpages < ActiveRecord::Migration[5.0]
  def change
    create_table :staticpages do |t|

      t.timestamps
    end
  end
end
