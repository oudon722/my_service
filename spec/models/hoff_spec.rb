require 'rails_helper'

RSpec.describe Hoff, type: :model do
  before do
    @hoff = FactoryBot.create(:hoff)
  end

  it "is valid with name and dates" do
    expect(@hoff).to be_valid
  end

  #名前がないと無効
  it "is invalid without name" do
    hoff = FactoryBot.build(:hoff, name: nil)
    hoff.valid?
    expect(hoff.errors[:name]).to include("を入力してください")
  end

  #日付がないと無効
  it "is invalid without dates" do
    hoff = FactoryBot.build(:hoff, dates: nil)
    hoff.valid?
    expect(hoff.errors[:dates]).to include("を入力してください")
  end

  #日付が現在より前なら無効
  it "is invalid when dates has passed" do
    hoff = FactoryBot.build(:hoff, :passed_dates)
    hoff.valid?
    expect(hoff.errors[:dates]).to include("は現在時刻より後の時間を入力してください")
  end
end
