FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@test.com"
    end
    password { "password" }
  end
  factory :admin_user do
    sequence :email do |n|
      "admin#{n}@test.com"
    end
    password { "password" }
  end
  factory :league
  factory :team
  factory :league_tournament
  factory :tournament
  factory :roster do
    winner { false }
  end
  factory :roster_player
  factory :player do
    sequence(:external_id) { |n| 1_000_000 + n } # clear of seeded players' ESPN ids
  end
end
