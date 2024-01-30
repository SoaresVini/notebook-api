class KindsController < ApplicationController

  #before_action :authenticate_user!

  #TOKEN = "Senha1234"

  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # http_basic_authenticate_with name: "vini", password: "secret"

  # include ActionController::HttpAuthentication::Digest::ControllerMethods
  # USERS = { "vini" => Digest::MD5.hexdigest(["vini","Application","secret"].join(":"))}
  
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authenticate

  before_action :set_kind, only: %i[ show update destroy ]

  # GET /kinds
  def index
    @kinds = Kind.all

    render json: @kinds #include: :contacts
  end
  # GET /kinds/1
  def show
    render json: @kind
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kind
      if params[:contact_id]
        @kind = Contact.find(params[:contact_id]).kind
        return @kind
      end

      @kind = Kind.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kind_params
      params.require(:kind).permit(:description)
    end

    # def authenticate
    #   # authenticate_or_request_with_http_digest("Application") do |username|
    #   #   USERS[username]
    #   # end

    #   #Evita ser atacado por uma parada que comprara strings 
    #   authenticate_or_request_with_http_token do |token, options| #Cosgue estrar qualuqer coisa que está no Authorization 
    #     hmac_secret = "$enhaK3y"
    #     JWT.decode token, hmac_secret,true,{ :algorithm => 'HS256' }
    #   #   ActiveSupport::SecurityUtils.secure_compare(
    #   #     ::Digest::SHA256.hexdigest(token),
    #   #     ::Digest::SHA256.hexdigest(TOKEN)
    #   #   )
    #   end
    # end
end
