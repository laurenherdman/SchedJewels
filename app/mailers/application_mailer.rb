class ApplicationMailer < ActionMailer::Base
  default from: "schedjewelsapp@gmail.com"
  def new_event_email(user)
  	# @user = user
#  	@proposal = Proposal.find(params[:id])
 # 	@url = proposal_path(@proposal)
  	mail(to: user["email"], subject: "You've been invited to an event on SchedJewels")

  end
end
