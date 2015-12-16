class AddColumnToTimeslotTable < ActiveRecord::Migration
  def change
  	add_column :timeslots, :proposal_id, :integer
  end
end
