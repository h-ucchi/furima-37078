class ItemsController < ApplicationController
  before_action :move_to_user_session, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :destroy]
  before_action :move_to_root_ordered, only: [:edit]
  
  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end


  private

  def item_params
    params.require(:item).permit(:title,:description,:category_id, :item_condition_id, :delivery_cost_id, :area_id, :delivery_day_id, :image, :price).merge(user_id: current_user.id)
  end

  def set_item #下部のmove_to_user_sessionで@itemを使うので、private内に@itemを定義する必要あり
    # @itemを定義することで以下の記述が上記にもあれば、before_actionを記述することでまとめられる
    @item = Item.find(params[:id])
  end

  def move_to_user_session
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

  def move_to_root
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def move_to_root_ordered
    unless @item.order == nil #商品に紐づくorder情報があるかないかを確認する（=ではだめで、==にしないといけない）
      redirect_to root_path
    end
  end

end
