# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do |n|
#   User.find_or_create_by(
#     first_name: "test_first#{n + 1}",
#     last_name: "test_last#{n + 1}",
#     player_name: "tester#{n + 1}",
#     email: "test#{n + 1}@example.com",
#     password: "passw0rd",
#     activated: true
#   )
# end

50.times do |n|
  d1 = Time.parse("2020/5/7 00:00")
  d2 = Time.parse("2020/5/14 00:00")
  owner_id = rand(1..5)
  owner_id1 = owner_id
  puts owner_id == owner_id1
  dates = rand(d1..d2)
  dates1 = dates
  prefecture_id = rand(1..47)
  prefecture_id1 = prefecture_id
  puts "start to create hoffs"
  Hoff.create!(
    owner_id: owner_id1,
    name: "テスト宅オフ#{n}(tester#{owner_id1}主催)",
    dates: dates1,
    end_dates: rand(dates1..d2),
    prefecture_id: prefecture_id1,
    city_id: City.find_by(prefecture_id: prefecture_id1).id,
    required_level: rand(1..3),
    pt_cost: rand(0..2000),
    max_pt_count: rand(2..10),
    station_name: "テスト駅",
    parking_space: rand(1..3),
    details: "これはテストです"
  )
end
