require 'rails_helper'

RSpec.feature "Users", type: :feature do
  #root_pathからユーザーが新規登録画面に移動し、新規登録できる
  scenario "can sign up nomally" do
    visit root_path
    expect{
      click_link "新規登録"
      fill_in "姓", with: "test"
      fill_in "名", with: "example"
      fill_in "ゲーム内での名前", with: "player"
      fill_in "メールアドレス", with: "example@example.com"
      fill_in "パスワード", with: "passw0rd"
      fill_in "パスワード(確認)", with: "passw0rd"
      click_button "ユーザー新規作成！"
      expect(page).to have_content("player")
      expect(page).to have_content("ユーザー登録完了！")
    }.to change{User.count}.by(1)
  end
end
