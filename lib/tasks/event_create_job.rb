class EventCreateJob
	@queue = :event_create

	def self.perform(uid)
		user = User.find(uid)
		UserMailer.event_create(@user).deliver
	end
end