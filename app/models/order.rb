class Order < ApplicationRecord
  attr_accessor :token
  
  belongs_to :user
  belongs_to :item
  has_one :shipping_adress

  validates :price, presence: true
  validates :token, presence: true
end
