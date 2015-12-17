class AddColumnToProposalTableTimeSlot < ActiveRecord::Migration
  def change
  	add_column :proposals, :time_zone, :string
  	add_column :timeslots, :time_zone, :string
  end
end
