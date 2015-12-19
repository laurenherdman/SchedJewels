class ChangeAttendeesProposalIdToInteger < ActiveRecord::Migration
  def change
  	remove_column :attendees, :proposal_id, :string
  	add_column :attendees, :proposal_id, :integer
  end
end
