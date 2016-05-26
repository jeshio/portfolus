FactoryGirl.define do
  factory :project_technology do
    #  technology_id :integer
    #  project_id    :integer
    power { rand(1..10) }
  end
end
