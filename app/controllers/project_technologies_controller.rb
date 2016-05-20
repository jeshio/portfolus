class ProjectTechnologiesController < ApplicationController
  before_action :set_project_technology, only: [:show, :update, :destroy]

  # GET /project_technologies
  def index
    @project_technologies = ProjectTechnology.all

    render json: @project_technologies
  end

  # GET /project_technologies/1
  def show
    render json: @project_technology
  end

  # POST /project_technologies
  def create
    @project_technology = ProjectTechnology.new(project_technology_params)

    if @project_technology.save
      render json: @project_technology, status: :created, location: @project_technology
    else
      render json: @project_technology.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /project_technologies/1
  def update
    if @project_technology.update(project_technology_params)
      render json: @project_technology
    else
      render json: @project_technology.errors, status: :unprocessable_entity
    end
  end

  # DELETE /project_technologies/1
  def destroy
    @project_technology.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_technology
      @project_technology = ProjectTechnology.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_technology_params
      params.require(:project_technology).permit(:technology_id, :project_id, :power)
    end
end
