module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.includes(:role)

        render json: users.as_json(
          except: [:password_digest],
          include: {
            role: {
              only: [:id, :name]
            }
          }
        )
      end

      def show

        user_id= params[:user_id]

        user = User.find(user_id)
        render json: user
      end
    end
  end
end
