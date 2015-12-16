class Proposal < ActiveRecord::Base

	belongs_to :owner, :class_name => "User"
	has_many :timeslots
	has_many :votes, through: :timeslots

	accepts_nested_attributes_for :timeslots, reject_if: :all_blank, allow_destroy: true
end
