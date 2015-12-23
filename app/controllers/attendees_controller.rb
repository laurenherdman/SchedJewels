class AttendeesController < ApplicationController

	def new
		@attendee = Attendee.new
	end

	def create
		@attendee = Attendee.new(attendee_params)
			if @attendee.save
			    redirect_to proposal_path(@proposal)
			else
				render :new
			end
	end

	def destroy
		@attendee = Attendee.destroy
	end

	private
	def attendee_params
		params.require(:attendee).permit(:email_address)
	end
end
