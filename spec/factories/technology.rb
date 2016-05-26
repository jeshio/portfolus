FactoryGirl.define do
  factory :technology do
    sequence(:name) { |n| Faker::StarWars.vehicle + " #{n}" }
  end
end
