class ItemsController < ApplicationController
  before_action :move_to_user_session, only: [:edit, :new]
  
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def item_params
    params.require(:item).permit(:title,:description,:category_id, :item_condition_id, :delivery_cost_id, :area_id, :delivery_day_id, :image, :price).merge(user_id: current_user.id)
  end

  def move_to_user_session
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

end
