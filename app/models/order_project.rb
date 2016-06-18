# == Schema Information
#
# Table name: order_projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price_min   :integer
#  price_max   :integer
#  finished    :boolean
#  views       :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#  executer_id :integer
#


class OrderProject < ApplicationRecord
  # keep the default scope first (if any)

  # constants come up next

  # afterwards we put attr related macros
  belongs_to :category

  belongs_to :customer, class_name: "User"

  belongs_to :executer, class_name: "User", optional: true

  has_many :order_project_tags, dependent: :destroy

  has_many :tags, through: :order_project_tags

  has_many :order_project_technologies, dependent: :destroy

  has_many :technologies, through: :order_project_technologies

  has_many :order_executer_requests

  # followed by association macros

  # and validation macros

  # next we have callbacks

  # other macros (like devise's) should be placed after the callbacks
  def self.save_in_transaction(order_project, tags, technologies)
    @errors = {}
    @order_project = OrderProject.new(order_project)
    @order_project.valid?

    if @order_project.errors.messages.size > 0
      @errors[:order_project] = @order_project.errors.messages
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
      # TODO validates_associated
      # проект
      @order_project.save

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
        order_project_tags = (created_tag.ids + exist_tag_ids).map { |e| @order_project.order_project_tags.new ({tag_id: e})  }
        OrderProjectTag.import(order_project_tags, validate: false)
      end

      # технологии
      if technologies.size > 0
        order_project_techs = (created_tech.ids + exist_techs).map { |e| @order_project.order_project_technologies.new ({technology_id: e})  }
        OrderProjectTechnology.import(order_project_techs, validate: false)
      end

      if @errors.size > 0
        return { errors: @errors }
      end
    end

    return @order_project
  end

   # finally, scopes
end
