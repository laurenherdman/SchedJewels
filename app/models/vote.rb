class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :timeslot
	has_one :proposal, through: :timeslot

end
