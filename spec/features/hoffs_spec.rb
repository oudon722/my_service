require 'rails_helper'

RSpec.feature "Hoffs", type: :feature do
  include LoginSupport
  let(:user) {FactoryBot.create(:user)}
  let(:hoff) {FactoryBot.create(:hoff, owner: user)}
  scenario "user make a hoff" do
    visit root_path
    click_link 'ログイン'
    log_in_as(user)
    visit user_path(user)
    click_link '宅オフを作る'
    fill_in '宅オフの名前', with: 'テスト宅オフ'
    d = Date.tomorrow
    select d.month, :from => "hoff_dates_2i"
    select d.day, :from => "hoff_dates_3i"
    click_button '宅オフ作成！'
    expect(current_path).to eq user_path(user)
    expect(page).to have_content "宅オフを作成しました！"
    expect(page).to have_content "テスト宅オフ"
  end

  feature "user edit a hoff" do
    before do
      visit root_path
      click_link 'ログイン'
      log_in_as(user)
      visit edit_hoff_path(hoff)
    end

    scenario "with valid info" do
      fill_in '宅オフの名前', with: '修正した宅オフ'
      d = 2.day.after
      select d.month, :from => "hoff_dates_2i"
      select d.day, :from => "hoff_dates_3i"
      click_button '宅オフ情報更新！'
      expect(current_path).to eq hoff_path(hoff)
      expect(page).to have_content "修正した宅オフ"
      expect(page).to have_content "#{d.month}月#{d.day}日"
    end

    scenario "with invalid info" do
      fill_in '宅オフの名前', with: ''
      click_button '宅オフ情報更新！'
      expect(page).to have_content "宅オフの名前を入力してください"
      expect(current_path).to eq hoff_path(hoff)
      fill_in '宅オフの名前', with: '修正した宅オフ'
      d = 1.day.ago
      select d.month, :from => "hoff_dates_2i"
      select d.day, :from => "hoff_dates_3i"
      click_button '宅オフ情報更新！'
      expect(page).to have_content "開催日時は現在時刻以降の日時を指定してください"
      expect(current_path).to eq hoff_path(hoff)
    end
  end

  # scenario "user delete a hoff", focus: true do
  #   visit root_path
  #   click_link 'ログイン'
  #   log_in_as(user)
  #   visit hoff_path(hoff)
  #   click_link '宅オフを削除する'
  # end
end
