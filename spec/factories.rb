FactoryGirl.define do
  factory :league
  factory :team
  factory :league_tournament
  factory :tournament
  factory :user do
    email "email@email.com"
    password "password"
  end
end
