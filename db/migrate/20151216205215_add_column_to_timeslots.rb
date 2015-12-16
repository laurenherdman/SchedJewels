class AddColumnToTimeslots < ActiveRecord::Migration
  def change
  	add_column :timeslots, :start_time, :time
  	add_column :timeslots, :start_date, :date
  	add_column :timeslots, :end_time, :time
  	add_column :timeslots, :end_date, :date
  end
end
