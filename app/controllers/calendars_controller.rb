class CalendarsController < ApplicationController
	require 'icalendar'

	# Create a calendar with an event (standard method)
	def show
		cal = Icalendar::Calendar.new
		cal.event do |e|
		  e.dtstart     = Icalendar::Values::Date.new('20151228')
		  e.dtend       = Icalendar::Values::Date.new('20151228')
		  e.summary     = "Meeting with the man."
		  e.description = "Have a long lunch meeting and decide nothing..."
		  e.ip_class    = "PRIVATE"
		end

		cal.publish
	end

	def new
		cal = Calendar.new
		# 10.times { cal.event } # Create 10 events with only default data.
		# some_event = cal.events[5] # Grab it from the array of events

		# # Use the uid as the key in your app
		# key = some_event.uid

		# # so later you can find it.
		# same_event = cal.find_event(key)
	end
end
