class SearchController < ApplicationController
  # Контроллер для поиска проектов, пользователей и т.д.

  has_scope :min_projects
  has_scope :city_id

  def query
    result = [];

    case type_param
    when "executers"
      result = executers
    when "projects"

    when "orders"

    when "organizations"

    end

    render json: result
  end

  private

  def executers
    apply_scopes(User).all
  end

  def projects

  end

  def type_param
    params.permit(:type)[:type]
  end

end
