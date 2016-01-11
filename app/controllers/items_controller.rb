class ItemsController < ApplicationController

  def create
    @item = Item.new(item_params)
    @item.list = @list

    if @item.save
      redirect_to group_lists_items_path(@item)
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
    @item = Item.find(params[:id])
  end

private
  def item_params
    params.require(:item).permit(:name, :list_id, :group_id)
  end
end
