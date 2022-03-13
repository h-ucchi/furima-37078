class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :price, :user_id, :item_id, :number, :exp_month, :exp_year, :cvc, :post_code, :area_id, :municipality, :address, :building_name, :tell_number

  # ここにバリデーションの処理を書く
  with_options presence: true do #建物名以外は必須
    validates :price
    validates :user_id
    validates :item_id
    validates :number
    validates :exp_month
    validates :exp_year
    validates :cvc
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :address
    validates :tell_number, format: { with: /\A[0-9]+\z/, message: "半角数字のみが使えます" }
  end

  validates_inclusion_of :price, in: 300..9999999, message: "は300円から9,999,999円までの金額を登録できます"

  def save
    # 商品情報を保存し、変数orderに代入する
    order = Order.create(price: price, user_id: user_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    ShippingAddress.create(post_code: post_code, area_id: area_id, municipality: municipality, address: address, building_name: building_name, tell_number: tell_number, order_id: order.id)
  end

end