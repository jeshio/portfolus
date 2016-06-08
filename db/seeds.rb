# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_girl_rails'
require 'faker'

# страны с городами
FactoryGirl.create_list(:country_with_cities, 5)

# пользователи
FactoryGirl.create_list(:user, 20, max_city_id: 25)

# с дополнительными email'ами
FactoryGirl.create_list(:user_with_emails, 15, max_city_id: 25, domen: "test.ru")
FactoryGirl.create_list(:user_with_emails, 15, max_city_id: 25, domen: "mail.ru")
FactoryGirl.create_list(:user_with_emails, 15, max_city_id: 25, domen: "samsung.com")

# категории
FactoryGirl.create_list(:category, 7)

# теги и технологии
FactoryGirl.create_list(:tag, 30)
FactoryGirl.create_list(:technology, 30)

# проекты
FactoryGirl.create_list(:project_with_additions, 20, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30)
FactoryGirl.create_list(:project_with_additions, 20, :dev_finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30)
FactoryGirl.create_list(:project_with_additions, 20, :finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30)

# с подтверждениями
FactoryGirl.create_list(:project_with_confirms, 20, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65)
FactoryGirl.create_list(:project_with_confirms, 20, :dev_finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65)
FactoryGirl.create_list(:project_with_confirms, 20, :finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65)

# с участниками проектов
FactoryGirl.create_list(:project_with_confirms, 30, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65,
  max_excuters_count: 10, max_excuter_id: 65)
FactoryGirl.create_list(:project_with_confirms, 30, :dev_finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65,
  max_excuters_count: 10, max_excuter_id: 65)
FactoryGirl.create_list(:project_with_confirms, 30, :finished, max_creater_id: 65, max_category_id: 7, max_tag_id: 30, max_tech_id: 30, max_confirm_count: 10, max_confirmer_id: 65,
  max_excuters_count: 10, max_excuter_id: 65)

# организации
testAdmin = User.find(rand(21..35));
FactoryGirl.create(:organization, creater_id: testAdmin.id, admin_email: testAdmin.email, domen_name: "test.ru")

mailAdmin = User.find(rand(36..50));
FactoryGirl.create(:organization, creater_id: mailAdmin.id, admin_email: mailAdmin.email, domen_name: "mail.ru")

samsungAdmin = User.find(rand(51..65));
FactoryGirl.create(:organization, creater_id: samsungAdmin.id, admin_email: samsungAdmin.email, domen_name: "samsung.com")
