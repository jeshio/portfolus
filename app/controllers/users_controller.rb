class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:all_projects]
  before_action :current_user?, only: [:show, :update]
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
    @data = @user.executed_projects

    render json: @data.as_json(include: { project_technologies: { include: :technology }, tags: {},
      project_executers: { include: :project_confirms }, :project_executers => { include: :executer } })
  end

  # запросы других пользователей об участии в проектах текущего пользвоателя
  def executer_requests
    # не подтверждённые создателем записи об участии
    @requested_projects = ProjectExecuter.where("project_id IN (?) AND creater_confirmed = ?", current_user.created_projects.ids, FALSE).all
    render json: @requested_projects.as_json(include: { :project => {}, :executer => {} })
  end

  # запросы создателей проектов об участии текущего пользователя
  def to_executer_requests
    @requested_projects = ProjectExecuter.where({executer_id: current_user.id, executer_confirmed: false})
    render json: @requested_projects.as_json(include: { project: { include: :creater } })
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
