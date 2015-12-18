class AddColumnsToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :body_text, :text
  	add_column :comments, :proposal_id, :integer
  	add_column :comments, :user_id, :integer
  end
end
