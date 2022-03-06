FactoryBot.define do
  factory :item do
    title               {'aaaaaaaa'}
    description         {Faker::Lorem.sentence}
    category_id         {2}
    item_condition_id   {2}
    area_id             {2}
    delivery_day_id     {2}
    delivery_cost_id    {2}
    price               {'2000'}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
