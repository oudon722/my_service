require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  #姓と名、emailとプレイヤーネームとパスワード、確認用パスワードがあると有効
  it "is valid with first_name, last_name, player_name and email, password, password_confirmation" do
    expect(@user).to be_valid
  end

  #姓がないと無効
  it "is invalid without last_name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("を入力してください")
  end

  #名がないと無効
  it "is invalid without first_name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("を入力してください")
  end

  #emailがないと無効
  it "is invalid without email adress" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  #プレイヤーネームがないと無効
  it "is invalid without player_name" do
    user = FactoryBot.build(:user, player_name: nil)
    user.valid?
    expect(user.errors[:player_name]).to include("を入力してください")
  end

  #パスワードがないと無効
  it "is invalid without password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  #パスワード確認がパスワードと一致しないと無効
  it "is invalid without password_confirmation" do
    user = FactoryBot.build(:user, password: "samplepassw0rd", password_confirmation: "passw0rd")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  #パスワードは8文字以上16文字以下でなければ無効
  #７文字の時
  it "is invalid with very short password" do
    user = FactoryBot.build(:user, :short_password)
    user.valid?
    expect(user.errors[:password]).to include("は8文字以上で入力してください")
  end

  #8文字の時
  it "is invalid with very long password" do
    user = FactoryBot.build(:user, :long_password)
    user.valid?
    expect(user.errors[:password]).to include("は16文字以内で入力してください")
  end


  #21文字以上のプレイヤーネームは無効
  it "is invalid with player_name over 20 characters" do
    user = FactoryBot.build(:user, :long_player_name)
    user.valid?
    expect(user.errors[:player_name]).to include("は20文字以内で入力してください")
  end

  #重複したemailは無効
  it "is invalid with a duplicate email adress" do
    FactoryBot.create(:user, email: "example@example.com")
    user = FactoryBot.build(:user, email: "example@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  #emailアドレスが無効
  it "is invalid email adress" do
    user = FactoryBot.build(:user, :invalid_email_adress)
    user.valid?
    expect(user.errors[:email]).to include("の書式が正しくありません")
  end
end
