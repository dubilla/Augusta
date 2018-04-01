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
  factory :player do
    sequence :external_id do |n|
      n
    end
  end
  factory :draft
  factory :draft_pick
end
