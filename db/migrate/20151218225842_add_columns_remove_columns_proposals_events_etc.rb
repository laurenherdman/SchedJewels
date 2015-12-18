class AddColumnsRemoveColumnsProposalsEventsEtc < ActiveRecord::Migration
  def change
  	remove_column :proposals, :start_time, :datetime
  	remove_column :proposals, :end_time, :datetime
  	add_column :proposals, :start_time, :time
  	add_column :proposals, :start_date, :date
  	add_column :proposals, :end_time, :time
  	add_column :proposals, :end_date, :date

  	remove_column :timeslots, :start_time, :datetime
  	remove_column :timeslots, :end_time, :datetime
  	add_column :timeslots, :start_time, :time
  	add_column :timeslots, :start_date, :date
  	add_column :timeslots, :end_time, :time
  	add_column :timeslots, :end_date, :date

  end
end
