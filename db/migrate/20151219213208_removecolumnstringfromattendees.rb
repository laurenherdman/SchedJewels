class Removecolumnstringfromattendees < ActiveRecord::Migration
  def change
  	remove_column :attendees, :string, :string
  end
end
