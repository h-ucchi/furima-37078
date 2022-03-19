class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create] #before_actionにも順番がある
  before_action :move_to_root, only: [:create]

  def index
    @orders = Order.all
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    #住所・トークンの情報をparamsに入れたいので、requireで住所変数を呼び出して、変数の中の情報をpermitで許可してあげる
    #トークンの情報（≒カード情報）は"token: params[]"でcard.jsから持ってこれている
    params.require(:order_shipping_address).permit(:post_code, :area_id, :municipality, :address, :building_name, :tell_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id] )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] #秘密鍵を環境変数に置き換えた
    Payjp::Charge.create(
      amount: @item.price,           # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end
  
  def set_item 
    @item = Item.find(params[:item_id])
  end
  
  def move_to_root
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

end
