class ProposalAndEventAssociation < ActiveRecord::Migration
  def change
  	add_column :proposals, :event_id, :integer
  end
end
