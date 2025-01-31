FactoryBot.define do
  reset_token = User.new_token

  factory :user, aliases: [:owner] do
    first_name "太郎"
    last_name "田中"
    sequence(:email) { |n| "tester#{n}@example.com"}
    player_name "たろう"
    #has_secure_passwordで出来た２つの仮想的な属性
    password "examplepassw0rd"
    password_confirmation "examplepassw0rd"
    activated true
    station_datum_id 1
    # reset_digest fojdsakjvnsajnvsaknvji

    #無効なemailアドレス
    trait :invalid_email_adress do
      email "tester#example.com"
    end

    #７文字のパスワード
    trait :short_password do
      password "abc1234"
    end

    #17文字のパスワード
    trait :long_password do
      password "abc1234abc1234abc"
    end

    #21文字以上の名前
    trait :long_player_name do
      player_name "a"*21
    end

    #有効化されていないアカウント
    trait :not_activated do
      activated false
    end
  end
end
