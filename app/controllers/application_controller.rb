class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  def angular
    render 'layouts/application'
  end

  def get_commits
    require 'open-uri'
    render json: JSON.load(open("https://api.github.com/repos/jeshio/portfolus/commits")).
      map { |e| { message: e["commit"]["message"], date: e["commit"]["committer"]["date"], link: e["html_url"] }  }
  end

  protected

  # Проверка что текущий пользователь тот же, что в params[:id]
  def current_user?
    raise ActionController::RoutingError.new("Not found") if !authenticate_user! || current_user.id != params[:id].to_i
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :city_id, :name, :family, :middlename, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :city_id, :name, :family, :middlename, :remember_me) }
  end

end
