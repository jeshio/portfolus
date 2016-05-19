# This will guess the User class
FactoryGirl.define do
  factory :country do
    sequence(:name) { |n| "Страна №#{n}" }

    factory :country_with_cities do

      transient do
        cities_count 5
      end

      after(:create) do |country, evaluator|
        create_list(:city, evaluator.cities_count, country: country)
      end
    end
  end
end
