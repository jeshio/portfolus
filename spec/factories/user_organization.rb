FactoryGirl.define do
  factory :user_organization do
    start_date { Faker::Date.between(3.years.ago, 100.days.ago) }

    factory :finished_user_organization do
      finish_date { Faker::Date.between(49.days.ago, 1.days.ago) }
    end

    #  user_id         :integer
    #  organization_id :integer
    #  start_date      :datetime
    #  finish_date     :datetime
    #  status          :string
  end
end
