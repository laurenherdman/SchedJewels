class TimeslotsController < ApplicationController
  def index
  	@timeslots = Timeslot.all
  end

  def new
  	@timeslot = Timeslot.new
  end

  def create
  	@timeslot = Timeslot.new(timeslot_params).in_time_zone('Eastern Time (US & Canada)')
  end

  def destroy
  	@timeslot = Timeslot.destroy
  end

  private
  	def timeslot_params
  		params.require(:timeslot).permit(:start_date, :start_time, :end_date, :end_time, :time_zone)
  	end
end
