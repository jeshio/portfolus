class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]

  # GET /organizations
  def index
    @organizations = Organization.where({creater_id: params[:user_id]}).all

    render json: @organizations
  end

  # GET /organizations/1
  def show
    render json: @organization
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)

    @organization.creater = current_user

    if @organization.save
      render json: @organization, status: :created, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # все организации, в которых юзер админ
  def where_you_admin
    render json: Organization.where_admin(current_user.emails.pluck(:email).push(current_user.email))
  end

  # организации, в которые пользователь может вступить, но ещё не вступил
  def available
    render json: Organization.available(current_user.emails.pluck(:email).push(current_user.email), current_user.user_organizations.pluck(:organization_id))
  end

  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name, :description, :url, :reg_hash, :admin_email, :domen, :creater_id, :views)
    end
end
