class AddColumnToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :owner_id, :integer
  	add_column :groups, :user_id, :integer
  	add_column :groups, :title, :string
  end
end
