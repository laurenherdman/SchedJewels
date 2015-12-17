class Proposal < ActiveRecord::Base

	belongs_to :owner, :class_name => "User"
	has_many :timeslots
	has_many :votes, through: :timeslots
	has_and_belongs_to_many :users
	belongs_to :event

	accepts_nested_attributes_for :timeslots, reject_if: :all_blank, allow_destroy: true

	def winning_timeslot
		timeslots.max_by { |t| t.votes.count }
	end
		# current_proposal = timeslot.proposal_id

	def set_time
		win = winning_timeslot

		self.start_date = win.start_date
		self.start_time = win.start_time
		self.end_date = win.end_date
		self.end_time = win.end_time
		self.time_zone = win.time_zone

		self.save
	end


end
