FactoryBot.define do
  factory :order_shipping_address do
    post_code { '123-4567' }
    area_id { 2 }
    municipality { '江東区' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    tell_number { '09012345678' }
  end
end
