FactoryBot.define do
  factory :hoff do
    name "テスト宅オフ"
    dates 1.week.from_now
    association :owner

    trait :passed_dates do
      dates 1.day.ago
    end
  end

end
