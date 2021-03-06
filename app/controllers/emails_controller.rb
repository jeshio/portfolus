class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :update, :destroy]

  # GET /emails
  def index
    @emails = Email.where({user_id: params[:user_id]}).all

    render json: @emails
  end

  # GET /emails/1
  def show
    render json: @email
  end

  # POST /emails
  def create
    @email = Email.new(email_params)
    @email.user_id = current_user.id

    if @email.save
      render json: @email, status: :created, location: @email
    else
      render json: @email.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /emails/1
  def update
    if @email.update(email_params)
      render json: @email
    else
      render json: @email.errors, status: :unprocessable_entity
    end
  end

  # DELETE /emails/1
  def destroy
    @email.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      params.require(:email).permit(:email, :user, :confirm_hash, :confirmed)
    end
end
