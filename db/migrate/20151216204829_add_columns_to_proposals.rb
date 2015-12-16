class AddColumnsToProposals < ActiveRecord::Migration
  def change
  	add_column :proposals, :title, :string
  	add_column :proposals, :description, :text
  	add_column :proposals, :location, :string
  	add_column :proposals, :start_time, :datetime
  	add_column :proposals, :end_time, :datetime
  end
end
