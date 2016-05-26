FactoryGirl.define do
  factory :city do
    country
    sequence(:name) { |n| Faker::Address.city + " #{n}" }
  end
end
