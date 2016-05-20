class ProjectConfirmsController < ApplicationController
  before_action :set_project_confirm, only: [:show, :update, :destroy]

  # GET /project_confirms
  def index
    @project_confirms = ProjectConfirm.all

    render json: @project_confirms
  end

  # GET /project_confirms/1
  def show
    render json: @project_confirm
  end

  # POST /project_confirms
  def create
    @project_confirm = ProjectConfirm.new(project_confirm_params)

    if @project_confirm.save
      render json: @project_confirm, status: :created, location: @project_confirm
    else
      render json: @project_confirm.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /project_confirms/1
  def update
    if @project_confirm.update(project_confirm_params)
      render json: @project_confirm
    else
      render json: @project_confirm.errors, status: :unprocessable_entity
    end
  end

  # DELETE /project_confirms/1
  def destroy
    @project_confirm.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_confirm
      @project_confirm = ProjectConfirm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_confirm_params
      params.require(:project_confirm).permit(:confirmer_id, :project_executer_id, :comment)
    end
end