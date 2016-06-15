class OrderProjectTechnologiesController < ApplicationController
  before_action :set_order_project_technology, only: [:show, :update, :destroy]

  # GET /order_project_technologies
  def index
    @order_project_technologies = OrderProjectTechnology.all

    render json: @order_project_technologies
  end

  # GET /order_project_technologies/1
  def show
    render json: @order_project_technology
  end

  # POST /order_project_technologies
  def create
    @order_project_technology = OrderProjectTechnology.new(order_project_technology_params)

    if @order_project_technology.save
      render json: @order_project_technology, status: :created, location: @order_project_technology
    else
      render json: @order_project_technology.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_project_technologies/1
  def update
    if @order_project_technology.update(order_project_technology_params)
      render json: @order_project_technology
    else
      render json: @order_project_technology.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_project_technologies/1
  def destroy
    @order_project_technology.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_project_technology
      @order_project_technology = OrderProjectTechnology.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_project_technology_params
      params.require(:order_project_technology).permit(:order_project)
    end
end
