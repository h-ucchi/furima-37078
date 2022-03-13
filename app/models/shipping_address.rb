class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :order
  belongs_to :item
  belongs_to :area
  
end
