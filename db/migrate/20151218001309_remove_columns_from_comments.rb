class RemoveColumnsFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :show, :string
  	remove_column :comments, :create, :string
  	remove_column :comments, :destroy, :string
  end
end
