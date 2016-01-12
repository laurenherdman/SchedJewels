class ListsController < ApplicationController
  def create
  	@list = List.new(list_params)
  	@list.user = current_user

  	if @list.save
  		redirect_to group_list_path(@group, @list)
  	else
  		redirect_to group_path(@list.group), notice: "There was an error."
  	end
  end

  def new
  	@list = List.new
  end

  def index
  	@lists = List.all
  end

  def show
    @group = Group.find(params[:group_id])
    @list = List.find(params[:id])
    @item = Item.new
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
  end

private
	def list_params
		params.require(:list).permit(:name, :group_id)
	end
end
