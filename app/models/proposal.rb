class Proposal < ActiveRecord::Base

	belongs_to :owner, :class_name => "User"
	has_many :timeslots
	has_many :attendees
	has_many :votes, through: :timeslots
	has_and_belongs_to_many :users
	belongs_to :event

	has_many :comments
	has_many :commenting_users, through: :comments, :source => :user

	accepts_nested_attributes_for :timeslots, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

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


		self.save
	end


	def attendee_array 
        attend_array = []  
        self.attendees.each do |a|
        	attend_array << { "email" => a.email_address }
        end 
        puts attend_array
        self.save
    end 

end
