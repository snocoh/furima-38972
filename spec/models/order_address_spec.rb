require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(0.5)
    end


    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end

      it 'buildingは空でも保存できる' do
        @order_address.building = ""
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できない' do
        @order_address.postcode = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は不正な値です")
      end

      it 'postcodeは「3桁ハイフン4桁」でないと保存できない' do
        @order_address.postcode = '1234-567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'postcodeは半角文字列でないと保存できない' do
        @order_address.postcode = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'postcodeはハイフンがないと保存できない' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号は不正な値です")
      end

      it 'prefectureに「---」が選択されている場合は登録できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end

      it 'cityが空だと保存できない' do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'streetが空だと保存できない' do
        @order_address.street = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空だと保存できない' do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberは半角数値でなければ保存できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は数値で入力してください")
      end

      it 'phone_numberは9桁以下では保存できない' do
        @order_address.phone_number = '090'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は10文字以上で入力してください")
      end

      it 'phone_numberは12桁以上では保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end

      it 'userが紐づいていなければ保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐づいていなければ保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空だと保存できない' do
        @order_address.token = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

    end

  end
end