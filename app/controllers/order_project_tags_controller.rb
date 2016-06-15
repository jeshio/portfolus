class OrderProjectTagsController < ApplicationController
  before_action :set_order_project_tag, only: [:show, :update, :destroy]

  # GET /order_project_tags
  def index
    @order_project_tags = OrderProjectTag.all

    render json: @order_project_tags
  end

  # GET /order_project_tags/1
  def show
    render json: @order_project_tag
  end

  # POST /order_project_tags
  def create
    @order_project_tag = OrderProjectTag.new(order_project_tag_params)

    if @order_project_tag.save
      render json: @order_project_tag, status: :created, location: @order_project_tag
    else
      render json: @order_project_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_project_tags/1
  def update
    if @order_project_tag.update(order_project_tag_params)
      render json: @order_project_tag
    else
      render json: @order_project_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_project_tags/1
  def destroy
    @order_project_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_project_tag
      @order_project_tag = OrderProjectTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_project_tag_params
      params.require(:order_project_tag).permit(:order_project)
    end
end
