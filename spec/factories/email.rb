FactoryGirl.define do
  factory :email do
    transient do
      domen "dope.dod"
    end

    sequence(:email) { |n| "person#{n}@#{domen}" }

    #  email      :string
    #  confirm_hash       :string
    #  confirmed  :boolean          default("false")
    #  user_id    :integer
  end
end
