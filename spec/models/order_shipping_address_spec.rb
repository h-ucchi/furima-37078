require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
    end

    # token情報を入れる必要があるが、orderファイルをBeforeActionで生成するとエラーになる。
    # 多分ファイルの並び順的にorderの方が上にあるからだと思う
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
      it "tokenが空では登録できないこと" do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      
      it 'post_codeが空だと保存できないこと' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.post_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      
      it 'areaを選択していないと保存できないこと' do
        @order_shipping_address.area_id = '1'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Area can't be blank")
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

      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end

      it '電話番号が空では購入できない' do
        @order_shipping_address.tell_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tell number can't be blank")
      end
      it '電話番号が9桁以下では購入できない' do
        @order_shipping_address.tell_number = '1234'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tell number is too short (minimum is 10 characters)")
      end
      it '電話番号が12桁以上では購入できない' do
        @order_shipping_address.tell_number = '123456789012'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tell number is too long (maximum is 11 characters)")
      end
      it '電話番号に半角数字以外が含まれている場合は購入できない（※半角数字以外が一文字でも含まれていれば良い）' do
        @order_shipping_address.tell_number = '１１１'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tell number は半角数字のみが使えます")
      end
    end
  end
end
