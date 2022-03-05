class ItemsController < ApplicationController

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(pulldown_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def pulldown_params
    params.require(:item).permit(:title,:text,:category_id, :item_condition_id, :delivery_cost_id, :area_id, :delivery_day_id)
  end

end
