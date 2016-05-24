class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user?, only: [:show, :update, :all_projects]
  before_action :set_user

  # GET /users/1
  def show
    render json: @user
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def all_projects
    @data = @user.all_projects
    render json: @data.to_json(:include => { :technologies => { :only => [:technology_id, :name] }, :tags => { :only => :name } })
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :family, :middlename, :city_id, :username, :password, :email)
    end
end
