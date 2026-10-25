class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    authorization_header = request.headers["Authorization"]
    token = authorization_header&.match(/\ABearer\s+(\S+)\z/i)&.captures&.first

    payload = JsonWebToken.decode(token) if token.present?

    @current_user = User.find_by(id: payload[:user_id]) if payload

    return if @current_user

    render json: { error: "Unauthorized" },
           status: :unauthorized
  end
end
