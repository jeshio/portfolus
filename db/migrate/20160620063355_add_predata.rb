class AddPredata < ActiveRecord::Migration[5.0]
  def up
    country = Country.create!(name: 'Российская Федерация')

    City.create!(name: "Москва", country: country)
    City.create!(name: "Санкт-Петербург", country: country)
    City.create!(name: "Ханты-Мансийск", country: country)
    City.create!(name: "Сургут", country: country)
    City.create!(name: "Мичуринск", country: country)
    City.create!(name: "Нягань", country: country)
    City.create!(name: "Нижневартовск", country: country)
    City.create!(name: "Пыть-Ях", country: country)
    City.create!(name: "Белоярский", country: country)

    Category.create!(name: 'Информационные технологии')
    Category.create!(name: 'Фотография')
    Category.create!(name: 'Музыка')
    Category.create!(name: 'Журналистика')
    Category.create!(name: 'Медицина')
    Category.create!(name: 'Образование')
  end
end
