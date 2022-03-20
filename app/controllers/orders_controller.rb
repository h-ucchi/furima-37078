class OrdersController < ApplicationController
  before_action :move_to_user_session, only: [:index]
  before_action :set_item #before_actionにも順番がある
  before_action :move_to_root, only: [:index]
  before_action :move_to_root_ordered, only: [:index]


  def index
    @orders = Order.all
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
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

  def move_to_user_session
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

  def move_to_root
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def move_to_root_ordered
    unless @item.order == nil #商品に紐づくorder情報があるかないかを確認する（=ではだめで、==にしないといけない）
      redirect_to root_path
    end
  end

end
