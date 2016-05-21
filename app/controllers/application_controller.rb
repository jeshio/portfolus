class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  def angular
    render 'layouts/application'
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
