class ProjectExecutersController < ApplicationController
  before_action :set_project_executer, only: [:show, :update, :destroy]

  # GET /project_executers
  def index
    @project_executers = ProjectExecuter.all

    render json: @project_executers
  end

  # GET /project_executers/1
  def show
    render json: @project_executer
  end

  # POST /project_executers
  def create
    @project_executer = ProjectExecuter.new(project_executer_params)

    if @project_executer.save
      render json: @project_executer, status: :created, location: @project_executer
    else
      render json: @project_executer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /project_executers/1
  def update
    if @project_executer.update(project_executer_params)
      render json: @project_executer
    else
      render json: @project_executer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /project_executers/1
  def destroy
    @project_executer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_executer
      @project_executer = ProjectExecuter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_executer_params
      params.require(:project_executer).permit(:project_id, :executer_id, :role, :start_date, :finish_date, :executer_confirmed, :creater_confirmed)
    end
end
