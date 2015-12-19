class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :email_address
      t.string :string

      t.timestamps null: false
    end
  end
end
