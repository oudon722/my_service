require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  #ユーザーがログインに失敗したとき、フラッシュメッセージを表示する
  scenario "login with invalid information" do
    visit login_path
    click_button "ログイン"
    visit root_path

    expect(page).to_not have_css(".alert.alert-danger")
  end
end
