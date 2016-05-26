class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.save_project_and_dependences(project_params, project_tags, project_technologies)

    if !@project[:errors]
      render json: @project, status: :created, location: @project
    else
      render json: { errors: @project[:errors] }.to_json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :description, :start_date, :dev_finish_date,
        :finish_date, :views, :version, :category_id, :clieint_id, :organization_id).merge(creater_id: current_user.id)
    end

    def project_technologies
      params[:project][:technologies] ||= []
      params.require(:project).permit(technologies: [:name, :power]).to_h[:technologies]#.to_a.map { |e| e.to_a }
    end

    def project_tags
      params[:project][:tags] ||= []
      params.require(:project).permit(:tags =>[])[:tags]
    end
end
