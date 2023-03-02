require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(1)
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
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank", "Postcode is invalid")
      end

      it 'postcodeは「3桁ハイフン4桁」でないと保存できない' do
        @order_address.postcode = '1234-567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid")
      end

      it 'postcodeは半角文字列でないと保存できない' do
        @order_address.postcode = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid")
      end

      it 'postcodeはハイフンがないと保存できない' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid")
      end

      it 'prefectureが空だと保存できない' do
        @order_address.prefecture_id = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できない' do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空だと保存できない' do
        @order_address.street = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street can't be blank")
      end

      it 'phone_numberが空だと保存できない' do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberは半角数値でなければ保存できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is not a number")
      end

      it 'phone_numberは9桁以下では保存できない' do
        @order_address.phone_number = '090'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end

      it 'phone_numberは12桁以上では保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end

      it 'userが紐づいていなければ保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていなければ保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空だと保存できない' do
        @order_address.token = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

    end

  end
end