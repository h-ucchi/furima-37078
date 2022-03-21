class OrderShippingAddress
  include ActiveModel::Model
  # 今から保存したいテーブル（order, shipping_address）のカラムを入れる
  # 注意点：addressのテーブルの中には外部キーがあるが、saveメソッドが動いて初めてorderが生成されるので、attr_accessorには不要（入れても意味ない）
  attr_accessor :user_id, :item_id, :post_code, :area_id, :municipality, :address, :building_name, :tell_number, :token

  # ここにバリデーションの処理を書く
  # カード情報のバリデーションは不要（トークン化されているため）
  # priceのバリデーションも不要（金額情報は保存されていないため）
  with_options presence: true do #建物名以外は必須
    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :address
    validates :tell_number, format: { with: /\A[0-9]+\z/, message: "半角数字のみが使えます" }, length: { in: 10..11 }
    validates :token
  end

  def save
    # 商品情報を保存し、変数orderに代入する
    # order= で書くのは、orderテーブルに保存したい情報→orderテーブルのカラムを入れる
    order = Order.create(user_id: user_id, item_id: item_id)
    
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    shipping_address = ShippingAddress.create(post_code: post_code, area_id: area_id, municipality: municipality, address: address, building_name: building_name, tell_number: tell_number, order_id: order.id)
  end

end