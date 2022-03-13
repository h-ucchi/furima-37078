require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      
      it 'areaを選択していないと保存できないこと' do
        @order_shipping_address.area = '1'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      
      it 'municipalityを入力していないと保存できないこと' do
        @order_shipping_address.municipality = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressを入力していないと保存できないこと' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'priceが空だと保存できないこと' do
        @order_shipping_address.price = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Price code can't be blank")
      end
      
      it 'priceが全角数字だと保存できないこと' do
        @order_shipping_address.price = '２０００'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Price is invalid')
      end
      it 'priceが300円未満では保存できないこと' do
        @order_shipping_address.price = '299'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Price is invalid')
      end
      it 'priceが10,000,000円より大きい場合は登録できない' do
        @order_shipping_address.price = '10000000'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Price is invalid')
      end
      
      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
