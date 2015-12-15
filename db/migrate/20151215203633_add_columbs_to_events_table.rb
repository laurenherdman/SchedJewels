class AddColumbsToEventsTable < ActiveRecord::Migration
  def change
  	add_column :events, :start_time, :dateTime
  	add_column :events, :end_time, :dateTime
  end
end
