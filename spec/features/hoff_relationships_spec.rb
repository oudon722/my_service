require 'rails_helper'

RSpec.feature "HoffRelationships", type: :feature do
  include LoginSupport
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, player_name: "tester2")
    @hoff1 = FactoryBot.create(:hoff, owner: @user)
    @hoff2 = FactoryBot.create(:hoff, name: "テスト2宅オフ", owner: @other_user)
  end
  scenario "user participant home-off" do
    visit root_path
    click_link 'ログイン'
    log_in_as(@user)
    #作成者は申請を送れない
    visit hoffs_path
    click_link @hoff1.name
    expect(page).to_not have_button "参加を申請する"
    #申請を送る
    visit hoffs_path
    click_link @hoff2.name
    expect(page).to have_button "参加を申請する"
    expect{
      click_button "参加を申請する"
      expect(current_path).to eq user_path(@user)
      expect(page).to have_content "参加申請を送りました！"
      expect(page).to have_content @hoff2.name
    }.to change{HoffRelationship.count}.by(1)
    #申請を許可する
    click_link 'ログアウト'
    click_link 'ログイン'
    log_in_as(@other_user)
    visit user_path(@other_user)
    click_link '承認'
    visit user_path(@user)
    expect(page).to have_content "テスト2宅オフ"
    expect(page).to have_css '.pt_hoff'
  end

  scenario "user is rejected to participant home-off", focus: true do
    visit root_path
    click_link 'ログイン'
    log_in_as(@user)
    #作成者は申請を送れない
    visit hoffs_path
    click_link @hoff1.name
    #申請を送る
    visit hoffs_path
    click_link @hoff2.name
    click_button "参加を申請する"
    expect(page).to have_content "テスト2宅オフ"
    click_link 'ログアウト'
    click_link 'ログイン'
    log_in_as(@other_user)
    visit user_path(@other_user)
    click_link '断る'
    visit user_path(@user)
    expect(page).to_not have_content "テスト2宅オフ"
  end
end
