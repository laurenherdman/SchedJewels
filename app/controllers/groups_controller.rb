class GroupsController < ApplicationController
  def index
  	@groups = Group.all
  end

  def new
  	@group = Group.new
  	@group.lists.build
  end

  def create
  	@group = Group.new(group_params)
  	@group.owner_id = current_user.id

  	if @group.save
  		redirect_to group_path(@group)
  	else
  		render :new
  	end
  end

  def show
  	@group = Group.find(params[:id])
    @comment = Comment.new
    @list = @group.lists.build
  end


private
	def group_params
		params.require(:group).permit(:id, :title)
			# item_attributes: [:id, :name]
	end
end