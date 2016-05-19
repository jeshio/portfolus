# This will guess the User class
FactoryGirl.define do
  factory :city do
    country
    sequence(:name) { |n| "Город №#{n}" }
  end
end
