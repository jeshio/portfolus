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

    factory :user_with_emails do
      transient do
        domen "dope.dod"
      end

      after(:create) do |user, evaluator|
        create(:email, user_id: user.id, domen: evaluator.domen)

        #дополнительные почты
        rand(0..5).times do |x|
          create(:email, user_id: user.id, domen: Faker::Internet.domain_name)
        end
      end
    end
  end
end
