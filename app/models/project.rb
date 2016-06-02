# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  start_date      :datetime
#  dev_finish_date :datetime
#  finish_date     :datetime
#  views           :decimal(, )
#  version         :string
#  category_id     :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  creater_id      :integer
#


class Project < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :category, optional: true

  belongs_to :client, class_name: "User", optional: true

  belongs_to :creater, class_name: "User", counter_cache: :created_projects_count

  belongs_to :organization, optional: true

  has_many :project_executers, dependent: :destroy

  has_many :project_tags, dependent: :destroy

  has_many :project_technologies, dependent: :destroy

  has_many :tags, through: :project_tags

  has_many :technologies, through: :project_technologies

  validates :name, length: { minimum: 2 }

  # followed by association macros

  # and validation macros

  # next we have callbacks
  after_create_commit :check_project_executer

  # other macros (like devise's) should be placed after the callbacks
  def self.save_project_and_dependences(project, tags, technologies)
    @errors = {}
    @project = Project.new(project)
    @project.valid?

    if @project.errors.messages.size > 0
      @errors[:project] = @project.errors.messages
    end

    if technologies.size > 0
      technology_names = technologies.map { |e| e[:name] }.uniq
      exist_techs = Technology.where({name: technology_names}).pluck(:name)
      tech_list = (technology_names - exist_techs).map { |e| Technology.new ({ name: e }) }
    end

    if tags.size > 0
      exist_tag = Tag.where({name: tags})
      tag_list = (tags.uniq - exist_tag.pluck(:name)).map { |e| Tag.new ({ name: e }) }
      exist_tag_ids = exist_tag.pluck(:id)
    end

    # создаём проект и все зависимости в одной транзакции
    ActiveRecord::Base.transaction do
      # TODO Multilevel с помощью гема Bulk imports
      # проект
      @project.save

      # технологии и теги
      if technologies.size > 0
        created_tech = Technology.import(tech_list, validate: true)
        if created_tech.failed_instances.size > 0
          @errors[:technology] = created_tech.failed_instances.first.errors.messages
        end
      end

      if tags.size > 0
        created_tag = Tag.import(tag_list, validate: true)
        if created_tag.failed_instances.size > 0
          @errors[:tag] = created_tag.failed_instances.first.errors.messages
        end
      end

      # посредники
      # теги
      if tags.size > 0
        project_tags = (created_tag.ids + exist_tag_ids).map { |e| @project.project_tags.new ({tag_id: e})  }
        ProjectTag.import(project_tags, validate: false)
      end

      # технологии
      if technologies.size > 0
        project_techs = Technology.where({id: (created_tech.ids + exist_techs)}).
          map { |e| ProjectTechnology.new ({project_id: @project.id, technology_id: e.id,
            power: (technologies.detect {|t| t[:name] == e.name })[:power] }) }
        tech_imported = ProjectTechnology.import(project_techs, validate: true)
        if tech_imported.failed_instances.size > 0
          msg = tech_imported.failed_instances.first.errors.messages
          @errors[:technology] = @errors[:technology] ?
            @errors[:technology] + msg : msg
        end
      end

      if @errors.size > 0
        return { errors: @errors }
      end
    end

    return @project
  end

  protected
  # проверка, что добавивший пользователь записан в исполнители
  def check_project_executer
    self.project_executers.first_or_create({ executer_confirmed: true, creater_confirmed: true, executer_id: self.creater_id })
  end

   # finally, scopes
end
