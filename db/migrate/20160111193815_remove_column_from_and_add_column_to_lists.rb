class RemoveColumnFromAndAddColumnToLists < ActiveRecord::Migration
  def change
  	remove_column :lists, :group_id
  	remove_column :lists, :integer

  	add_column :lists, :group_id, :integer
  end
end
