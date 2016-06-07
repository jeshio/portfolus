class UserOrganizationsController < ApplicationController
  before_action :set_user_organization, only: [:show, :update, :destroy]

  # GET /user_organizations
  def index
    @user_organizations = UserOrganization.where({user_id: params[:user_id]}).all

    render json: @user_organizations.as_json(include: { organization: {} })
  end

  # GET /user_organizations/1
  def show
    render json: @user_organization
  end

  # POST /user_organizations
  def create
    @user_organization = UserOrganization.new(user_organization_params)

    @user_organization.user = current_user

    if @user_organization.save
      render json: @user_organization, status: :created, location: @user_organization
    else
      render json: @user_organization.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_organizations/1
  def update
    if @user_organization.update(user_organization_params)
      render json: @user_organization
    else
      render json: @user_organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_organizations/1
  def destroy
    @user_organization.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_organization
      @user_organization = UserOrganization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_organization_params
      params.require(:user_organization).permit(:user_id, :organization_id, :start_date, :finish_date, :status)
    end
end
