class OrdersController < ApplicationController

  def index
    @orders = Order.all
    @item = Item.find(params[:item_id])
  end

  def new
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    #@order = Order.new(order_params)
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
    params.require(:order_shipping_address).permit(:price, :number, :exp_month, :exp_year, :cvc, :post_code, :area_id, :municipality, :address, :building_name, :tell_number).merge(token: params[:token], user_id: current_user.id )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] #秘密鍵を環境変数に置き換えた
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
