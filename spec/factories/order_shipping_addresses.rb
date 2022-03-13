FactoryBot.define do
  factory :order_shipping_address do
    post_code { '123-4567' }
    area { 2 }
    municipality { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    price { 2000 }
    
  end
end
