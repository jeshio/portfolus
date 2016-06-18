class OrderExecuterRequestsController < ApplicationController
  before_action :set_order_executer_request, only: [:show, :update, :destroy]

  # GET /order_executer_requests
  def index
    # TODO показывать только актуальные запросы
    @order_executer_requests = OrderExecuterRequest.where({executer_id: params[:user_id]}).all

    render json: @order_executer_requests.as_json(include: { order_project: {  } })
  end

  # GET /order_executer_requests/1
  def show
    render json: @executer_request
  end

  # POST /order_executer_requests
  def create
    @executer_request = OrderExecuterRequest.new(order_executer_request_params)

    if @executer_request.save
      render json: @executer_request, status: :created, location: @executer_request
    else
      render json: @executer_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_executer_requests/1
  def update
    if @executer_request.update(order_executer_request_params)
      render json: @executer_request
    else
      render json: @executer_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_executer_requests/1
  def destroy
    @executer_request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_executer_request
      @executer_request = OrderExecuterRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_executer_request_params
      params.require(:order_executer_request).permit(:order_project_id, :executer_id, :comment, :by_customer, :confirmed, :price)
    end
end
