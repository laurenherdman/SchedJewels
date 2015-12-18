class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :show
      t.string :create
      t.string :destroy

      t.timestamps null: false
    end
  end
end
