class ItemsController < ApplicationController
  before_action :load_list

  def create
    @item = Item.create(item_params)
    @group = Group.find(params[:group_id])
    @item.list_id = @list.id
    @item.group_id = @group.id

    if @item.save
      redirect_to group_list_path(@group, @list)
    else
      redirect_to group_path(@list.group), notice: "There was an error."
    end
  end

  def new
    @item = Item.new
  end

  def destroy
  end

  def index
    @items = Item.all
  end

  def show
    @group = Group.find(params[:group_id])
    @list = List.find(params[:list_id])
    @item = Item.new
  end

private
  def item_params
    params.require(:item).permit(:name, :list_id, :group_id)
  end

  def load_list
    @list = List.find(params[:list_id])
  end
end
