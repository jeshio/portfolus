FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| Faker::Color.color_name + " #{n}" }
  end
end
