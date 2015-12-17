class AddFunkyJoinTable < ActiveRecord::Migration
  def change
  	create_table :proposals_users do |t|
  		t.integer :user_id
  		t.integer :proposal_id
  	end
  end
end
