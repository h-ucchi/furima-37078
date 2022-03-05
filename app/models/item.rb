class Item < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :description
    validates :category_id
    validates :item_condition_id
    validates :area_id
    validates :delivery_day
    validates :price
    validates :delivery_cost_id
  end
end
