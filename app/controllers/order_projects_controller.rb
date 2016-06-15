class OrderProjectsController < ApplicationController
  before_action :set_order_project, only: [:show, :update, :destroy]

  # GET /order_projects
  def index
    @order_projects = OrderProject.where({customer_id: params[:user_id]}).all

    render json: @order_projects.as_json(include: { category: {}, technologies: {}, tags: {} })
  end

  # GET /order_projects/1
  def show
    render json: @order_project.as_json(include: :category)
  end

  # POST /order_projects
  def create
    @order_project = OrderProject.save_in_transaction(order_project_params, order_project_tags, order_project_technologies)

    if !@order_project[:errors]
      render json: @order_project, status: :created, location: @order_project
    else
      render json: { errors: @order_project[:errors] }.to_json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_projects/1
  def update
    if @order_project.update(order_project_params)
      render json: @order_project
    else
      render json: @order_project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_projects/1
  def destroy
    @order_project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_project
      @order_project = OrderProject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_project_params
      params.require(:order_project).permit(:name, :description, :price_min, :price_max, :category_id).merge(customer_id: current_user.id)
    end

    def order_project_technologies
      params[:order_project][:technologies] ||= []
      params.require(:order_project).permit(technologies: [:name, :power]).to_h[:technologies]
    end

    def order_project_tags
      params[:order_project][:tags] ||= []
      params.require(:order_project).permit(:tags =>[])[:tags]
    end
end
