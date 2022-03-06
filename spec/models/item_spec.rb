require 'rails_helper'

RSpec.describe Item, type: :model do
  before do #処理をまとめる
    @item = FactoryBot.build(:item) # Itemのインスタンス生成
  end

  describe '商品新規登録' do
    context '新規登録できるとき' do
      it '写真とタイトル、商品説明、商品詳細、配送情報、販売価格が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it '販売価格は300円〜9,999,999円までが登録可能である（300円を検証）' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '販売価格は300円〜9,999,999円までが登録可能である（9,999,999円を検証）' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    
    context '新規登録できないとき' do
      it '写真が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      
      it 'タイトルが空では登録できない' do
          @item.title = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '商品説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が空では登録できない' do
        @item.item_condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end
      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end

      it '発送料の負担が空では登録できない' do
        @item.delivery_cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery cost can't be blank")
      end
      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.delivery_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery cost can't be blank")
      end

      it '発送元の地域が空では登録できない' do
        @item.area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end
      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end

      it '発送までの日数が空では登録できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end

      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は300円から9,999,999円までの金額を登録できます')
      end
      it '価格が10,000,000円より大きい場合は登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は300円から9,999,999円までの金額を登録できます')
      end
      it '価格に半角数字以外が含まれている場合は出品できない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300円から9,999,999円までの金額を登録できます")
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

    end
  end
end
