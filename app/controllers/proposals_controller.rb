class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
    @comment = Comment.new(user: current_user, proposal: @proposal)
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.owner_id = current_user.id



    if @proposal.save
      @proposal.attendee_array.each do |a|
        UserMailer.new_event_email(a).deliver_now
      end
      redirect_to proposal_path(@proposal)
    else
      render :new
    end
  end

  def destroy
    @proposal = Proposal.destroy
  end

  private
    def proposal_params
      params.require(:proposal).permit(:title, :description, :location, timeslots_attributes:[:start_date, :start_time, :end_date, :end_time, :id, :time_zone], attendees_attributes:[:email_address])
    end
end
