class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.owner_id = current_user.id

    if @proposal.save
      redirect_to proposals_url
    else
      render :new
    end
  end

  def destroy
    @proposal = Proposal.destroy
  end

  private
    def proposal_params
      params.require(:proposal).permit(:title, :description, :location, timeslot_attributes:[:start_date, :start_time, :end_date, :end_time])
    end
end
