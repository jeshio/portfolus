class OrderProjectsController < ApplicationController
  before_action :set_order_project, only: [:show, :update, :destroy]

  # GET /order_projects
  def index
    @order_projects = OrderProject.where({customer_id: params[:user_id]}).all

    render json: @order_projects.as_json(include: { category: {} })
  end

  # GET /order_projects/1
  def show
    render json: @order_project.as_json(include: :category)
  end

  # POST /order_projects
  def create
    @order_project = OrderProject.new(order_project_params)

    if @order_project.save
      render json: @order_project, status: :created, location: @order_project
    else
      render json: @order_project.errors, status: :unprocessable_entity
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
end
