require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全項目が埋まっていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@を含まなければ登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'passwordは英字のみでは登録できない' do
        @user.password = 'ABCabc'
        @user.password_confirmation = 'ABCabc'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは全角文字を含む場合は登録できない' do
        @user.password = 'Abc1２３'
        @user.password_confirmation = 'Abc1２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（全角）を入力してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（全角）を入力してください")
      end

      it 'family_nameが全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.family_name = 'abcｱｲｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（全角）は不正な値です')
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.first_name = 'abcｱｲｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（全角）は不正な値です')
      end

      it 'kana_family_nameが空では登録できない' do
        @user.kana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓カナ（全角）を入力してください")
      end

      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナ（全角）を入力してください")
      end

      it 'kana_family_nameが全角（カタカナ）でない場合登録できない' do
        @user.kana_family_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓カナ（全角）は不正な値です')
      end

      it 'kana_first_nameが全角（カタカナ）でない場合登録できない' do
        @user.kana_first_name = 'ﾘﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナ（全角）は不正な値です')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
