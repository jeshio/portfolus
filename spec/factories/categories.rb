# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# This will guess the User class
FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.words(rand(1..2)).join(' ').capitalize }
  end
end
