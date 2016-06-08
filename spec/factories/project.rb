require 'set'

# генерирует последовательность уникальных чисел от 1 до max
def rand_n(n, max)
    randoms = Set.new
    loop do
        randoms << rand(1..max)
        return randoms.to_a if randoms.size >= n
    end
end

FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.sentence(1, true, 5) }
    description { Faker::Lorem.paragraph(2, true, 12) }
    start_date { Faker::Date.between(100.days.ago, 50.days.ago) }

    trait :dev_finished do
      start_date { Faker::Date.between(100.days.ago, 50.days.ago) }
      dev_finish_date { Faker::Date.between(49.days.ago, 30.days.ago) }
    end

    trait :finished do
      start_date { Faker::Date.between(150.days.ago, 100.days.ago) }
      dev_finish_date { Faker::Date.between(99.days.ago, 60.days.ago) }
      finish_date { Faker::Date.between(59.days.ago, 25.days.ago) }
    end

    transient do
      max_category_id 5
      max_creater_id 5
    end

    category_id { rand(1..max_category_id) }

    factory :project_with_additions do
      # с технологиями и тегами
      transient do
        max_tags_count 5
        max_tag_id 5

        max_tech_count 5
        max_tech_id 5
      end


      after(:create) do |project, evaluator|
        # генерим уникальные теги в количестве от 1 до max_tags_count
        tags_count = rand(1..evaluator.max_tags_count)
        tags = rand_n(tags_count, evaluator.max_tag_id)
        tags_count.times do |x|
            create(:project_tag, project_id: project.id, tag_id: tags[x])
        end
        # тоже с технологиями
        tech_count = rand(1..evaluator.max_tech_count)
        techs = rand_n(tech_count, evaluator.max_tech_id)
        tech_count.times do |x|
            create(:project_technology, project_id: project.id, technology_id: techs[x])
        end
      end

      factory :project_with_confirms do
        # с подтверждениями
        transient do
          max_confirm_count 5
          max_confirmer_id 5
        end

        after(:create) do |project, evaluator|
          executer = project.project_executers.first

          confirms_count = rand(1..evaluator.max_confirm_count)
          confirms = rand_n(confirms_count, evaluator.max_confirmer_id)
          confirms_count.times do |x|
            create(:project_confirm, project_executer_id: executer.id, confirmer_id:confirms[x])
          end

        end
      end
    end

    views { rand(0..10000) }
    version { Faker::App.version }

    #  category_id     :integer
    #  organization_id :integer
    #  client_id       :integer
    creater_id { rand(1..max_creater_id) }

    transient do
      max_excuters_count 0
      max_excuter_id 0
    end

    after(:create) do |project, evaluator|
      executers = rand_n(evaluator.max_excuters_count, evaluator.max_excuter_id) - [project.creater.id]
      rand(0..evaluator.max_excuters_count).times do |x|
        finished = [true, false].sample
        executer_confirms = [true, false].sample
        creater_confirms = [true, false].sample
        create(:project_executer, project_id: project.id, executer_id: executers[x],
          finished: finished, executer_confirmed: executer_confirms, creater_confirmed: creater_confirms)
      end
    end

  end
end
