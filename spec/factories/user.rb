# This will guess the User class
FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    family { Faker::Name.last_name }
    middlename { Faker::Name.suffix }
    email { Faker::Internet.email }
    password "pass12345"
  end
end
