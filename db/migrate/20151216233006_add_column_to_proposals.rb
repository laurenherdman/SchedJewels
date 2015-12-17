class AddColumnToProposals < ActiveRecord::Migration
  def change
  	add_column :proposals, :owner_id, :integer
  end
end
