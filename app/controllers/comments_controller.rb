class CommentsController < ApplicationController
	before_filter :load_proposal

	def show
		@comment = Comment.find(params[:id])
	end

	def create
		@comment = @proposal.comments.build(comment_params)
		@comment.user = current_user

		if @comment.save
			redirect_to proposal_url(@proposal), notice: "Your comment has been saved"
		else
			render 'proposals/show'
		end


	end

	def destroy
		@comment = Comment.find(params[:id])
		if @comment.present?
			@comment.destroy
		end
		redirect_to proposoal_url, notice: "Your comment has been deleted."
	end

	private

		def comment_params
			params.require(:comment).permit(:user_id, :comment_id, :body_text, :proposal_id)
		end

		def load_proposal
			@proposal = Proposal.find(params[:proposal_id])
		end
end
