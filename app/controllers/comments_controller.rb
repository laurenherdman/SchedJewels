class CommentsController < ApplicationController

	def show
		@comment = Comment.find(params[:id])
	end

	def create

		if params[:proposal_id]
			@proposal = Proposal.find(params[:proposal_id])
			@comment = @proposal.comments.build(comment_params)
			@comment.user = current_user
		elsif params[:group_id]
			@group = Group.find(params[:group_id])
			@comment = @group.comments.build(comment_params)
			@comment.user = current_user
		end


		if @comment.save
			if @proposal
				redirect_to proposal_url(@proposal), notice: "Your comment has been saved"
			elsif @group
				redirect_to group_url(@group), notice: "Your comment has been saved"
			end
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
			params.require(:comment).permit(:user_id, :comment_id, :body_text, :proposal_id, :group_id)
		end

		def load_proposal
			@proposal = Proposal.find(params[:proposal_id])
		end

		def load_group
			@group = Group.find(params[:group_id])
		end
end
