class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  def get_dialog
    @messages = Message.where('from_id = :first AND to_id = :second OR to_id = :first AND from_id = :second', {first: params[:first], second: params[:second]}).all
    render json: @messages.as_json(include: { to: {}, from: {} })
  end

  # возвращает список диалогов
  def dialogs
    @dialogs = Message.dialogs_for_user(current_user.id)
    render json: @dialogs.as_json(include: { from: {}, to: {} })
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:from_id, :to_id, :text, :readed)
    end
end
