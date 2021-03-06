FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@test.com"
    end
    password "password"
  end
  factory :league
  factory :team
  factory :league_tournament
  factory :tournament
  factory :roster do
    winner false
  end
  factory :roster_player
  factory :player
end
