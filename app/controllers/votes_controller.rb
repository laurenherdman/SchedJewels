class VotesController < ApplicationController
  def index
    @vote = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new
    @vote.user = current_user
    @timeslot = Timeslot.find(params[:timeslot_id])
    @vote.timeslot = @timeslot

    if @vote.save
      redirect_to proposal_path(@vote.proposal), notice: "Thank you for voting."
    else
      render :new, notice: "Please vote again."
    end
  end

  def destroy
    @vote = Vote.destroy
  end

end
