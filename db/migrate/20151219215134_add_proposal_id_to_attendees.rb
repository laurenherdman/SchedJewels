class AddProposalIdToAttendees < ActiveRecord::Migration
  def change
  	add_column :attendees, :proposal_id, :string
  end
end
