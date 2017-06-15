class CreateEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.column :name, :string
      t.column :date, :date
      t.column :start_time, :datetime
      t.column :end_time, :datetime
      t.column :event_code, :string
      t.column :session_type, :string
      t.column :prime_event, :string
      t.column :gender, :string
      t.column :detail, :text
    end
  end
end
