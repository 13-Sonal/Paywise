module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_request, only: [:create]

      def create
        user = User.find_by(email: params[:email]&.downcase&.strip)

        unless user&.authenticate(params[:password])
          return render json: {
            error: "Invalid email or password"
          }, status: :unauthorized
        end

        token = JsonWebToken.encode(user.id)
        render json: {
          token: token,
          user: {
            id: user.id,
            name: user.name,
            email: user.email,
            role_id: user.role_id,
            role_name: user.role&.name&.strip

          }
        }, status: :ok
      end
    end
  end
end