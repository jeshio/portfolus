FactoryGirl.define do
  factory :project_executer do
    role { Faker::Lorem.words(rand(1..3)).join(' ').capitalize }
    start_date Faker::Date.between(100.days.ago, 50.days.ago)

    transient do
      finished false
    end

    finish_date { Faker::Date.between(30.days.ago, 2.days.ago) if finished }

  end
end
