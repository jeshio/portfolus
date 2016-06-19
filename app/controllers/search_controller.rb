class SearchController < ApplicationController
  # Контроллер для поиска проектов, пользователей и т.д.

  has_scope :city_id, only: [:executers]
  has_scope :min_projects, only: [:executers]
  has_scope :organization_id, only: [:executers]

  has_scope :category_id, only: [:projects, :orders]
  has_scope :tags, only: [:projects, :orders]
  has_scope :technologies, only: [:projects, :orders]

  def executers
    render json: apply_scopes(User).all.as_json(include: :city)
  end

  def projects
    # TODO сделать лучше
    # сначала все id
    project_ids = Project.all.pluck(:id)

    # отсеивание по тегам
    if !request.GET[:tags].nil? && request.GET[:tags].length > 0
      request_tags = request.GET[:tags].map { |e| e.downcase }

      for_tags = Tag.where("lower(tags.name) IN (?)", request_tags).includes(:projects).all.pluck(:'projects.id')

      project_ids = project_ids & for_tags
    end

    # отсеивание по технологиям
    if !request.GET[:technologies].nil? && request.GET[:technologies].length > 0
      request_technologies = request.GET[:technologies].map { |e| e.downcase }

      for_technologies = Technology.where("lower(technologies.name) IN (?)", request_technologies).includes(:projects).all.pluck(:'projects.id')

      project_ids = project_ids & for_technologies
    end

    # применение скопов и выбор отсеиных проектов
    projects = apply_scopes(Project).where("id in (?)", project_ids).all

    render json: projects.as_json(include: { project_technologies: { include: :technology }, tags: {}, creater: {}, category: {} })
  end

  def orders
    # сначала все id
    order_project_ids = OrderProject.all.pluck(:id)

    # отсеивание по тегам
    if !request.GET[:tags].nil? && request.GET[:tags].length > 0
      request_tags = request.GET[:tags].map { |e| e.downcase }

      for_tags = Tag.where("lower(tags.name) IN (?)", request_tags).includes(:order_projects).all.pluck(:'order_projects.id')

      order_project_ids = order_project_ids & for_tags
    end

    # отсеивание по технологиям
    if !request.GET[:technologies].nil? && request.GET[:technologies].length > 0
      request_technologies = request.GET[:technologies].map { |e| e.downcase }

      for_technologies = Technology.where("lower(technologies.name) IN (?)", request_technologies).includes(:order_projects).all.pluck(:'order_projects.id')

      order_project_ids = order_project_ids & for_technologies
    end

    # применение скопов и выбор отсеиных проектов
    orders = apply_scopes(OrderProject).where("id in (?)", order_project_ids).all

    render json: orders.as_json(include: { technologies: {}, tags: {}, customer: {}, category: {} })
  end

end
