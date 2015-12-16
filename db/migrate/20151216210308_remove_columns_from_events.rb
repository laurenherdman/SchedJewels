class RemoveColumnsFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :start_time, :datetime
  	remove_column :events, :end_time, :datetime
  end
end