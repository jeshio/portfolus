# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_girl_rails'
require 'faker'

FactoryGirl.create_list(:country_with_cities, 5)
FactoryGirl.create_list(:user, 65, max_city_id: 25)
FactoryGirl.create_list(:category, 7)

FactoryGirl.create_list(:tag, 30)
FactoryGirl.create_list(:technology, 30)

FactoryGirl.create_list(:project_with_additions, 30, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30)
FactoryGirl.create_list(:project_with_additions, 30, :dev_finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30)
FactoryGirl.create_list(:project_with_additions, 30, :finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30)


FactoryGirl.create_list(:project_with_confirms, 70, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65)
FactoryGirl.create_list(:project_with_confirms, 70, :dev_finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65)
FactoryGirl.create_list(:project_with_confirms, 70, :finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65)
