class Proposal < ActiveRecord::Base
	belongs_to :owner, class_name => "User"
	has_many :timeslots
	has_many :votes, through: :timeslots

end
