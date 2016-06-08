FactoryGirl.define do
  factory :organization do
    transient do
      domen_name "dope.dod"
    end

    name { Faker::Company.name }
    description { Faker::Lorem.paragraph(2, false, 4) }
    sequence(:url) { |n| "http://#{domen_name}/company_page" }
    domen { domen_name }

    #  admin_email :string
  end
end
