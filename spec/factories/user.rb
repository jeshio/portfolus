FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    family { Faker::Name.last_name }
    middlename { Faker::Name.suffix }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "pass12345"

    transient do
      max_city_id 5
    end
    city_id { rand(1..max_city_id) }
  end
end
