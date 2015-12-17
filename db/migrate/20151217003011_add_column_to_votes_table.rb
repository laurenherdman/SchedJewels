class AddColumnToVotesTable < ActiveRecord::Migration
  def change
  	add_column :votes, :user_id, :integer
  	add_column :votes, :timeslot_id, :integer
  end
end
