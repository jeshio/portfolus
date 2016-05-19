require 'rails_helper'

RSpec.describe "Applications", :type => :request, js: true do

  let(:countries) { create_list(:country_with_cities, 2) }
  let(:user_example) { build(:user) }


  describe "авторизация" do
    before do
      visit '/auth'
    end

    describe "ввод верных данных" do
      before do
        user_example.save
        fill_in('email', :with => user_example.email)
        fill_in('password', :with => user_example.password)
        find("button[name='enter-button']").click
      end

      it "успешная авторизация" do
        expect(page).to have_content('Страница пользователя')
      end

      describe "выход" do
        before do
          click_on('Выйти')
        end

        it "пройден" do
          expect(page).to have_no_link('Выйти')
        end

        describe "повторная авторизация" do
          before do
            visit '/auth'
            fill_in('email', :with => user_example.email)
            fill_in('password', :with => user_example.password)
            find("button[name='enter-button']").click
          end

          it "успешная авторизация" do
            expect(page).to have_content("Страница пользователя")
          end
        end
      end

    end
  end

  describe "регистрация"  do
    before do
      visit '/register'
    end

    describe "первый шаг" do

      describe "верные данные" do
        before do
          fill_in('email', :with => user_example.email)
          fill_in('password', :with => user_example.password)
          click_on('Далее')
        end

        it "ввод верных данных" do
          expect(page).to have_content('Дополнительная информация')
        end

        describe "второй шаг" do

          describe "верные данные" do
            before do
              countries
              fill_in('family', :with => user_example.family)
              fill_in('name', :with => user_example.name)
              fill_in('middlename', :with => user_example.middlename)
              find("md-select[name='city_id']").set countries.second.cities.third.id
              click_on('Далее')
            end

            it "успешное прохождение регистрации" do
              expect(page).to have_content('Страница пользователя')
            end

            it "пользователь в базе данных" do
              user_db = User.find_by_email user_example.email
              user_db.name.should eq user_example.name
              user_db.family.should eq user_example.family
              user_db.middlename.should eq user_example.middlename
              user_db.city_id.should eq user_example.city_id
            end
          end
        end
      end

      it "ввод неверных данных" do
        fill_in('email', :with => "badEmail.com")
        fill_in('password', :with => user_example.password)
        have_field("Далее", :disabled => true)
      end

    end
  end
end
