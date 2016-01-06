class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :user_id
      t.integer :owner_id
      t.string :group_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
