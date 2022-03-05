class ItemsController < ApplicationController

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(category_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def category_params
    params.require(:item).permit(:title,:text,:category_id)
  end

end
