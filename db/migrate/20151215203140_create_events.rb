class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :google_event_id

      t.timestamps null: false
    end
  end
end
