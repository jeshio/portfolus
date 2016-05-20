class ProjectTagsController < ApplicationController
  before_action :set_project_tag, only: [:show, :update, :destroy]

  # GET /project_tags
  def index
    @project_tags = ProjectTag.all

    render json: @project_tags
  end

  # GET /project_tags/1
  def show
    render json: @project_tag
  end

  # POST /project_tags
  def create
    @project_tag = ProjectTag.new(project_tag_params)

    if @project_tag.save
      render json: @project_tag, status: :created, location: @project_tag
    else
      render json: @project_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /project_tags/1
  def update
    if @project_tag.update(project_tag_params)
      render json: @project_tag
    else
      render json: @project_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /project_tags/1
  def destroy
    @project_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_tag
      @project_tag = ProjectTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_tag_params
      params.require(:project_tag).permit(:technology_id, :project_id)
    end
end
