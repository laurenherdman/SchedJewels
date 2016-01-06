class AddColumnToItems < ActiveRecord::Migration
  def change
  	add_column :items, :name, :string
  	add_column :items, :group_id, :string
  end
end
