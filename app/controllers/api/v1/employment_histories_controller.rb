module Api
  module V1
    class EmploymentHistoriesController < ApplicationController
      def index 
        byebug
        records = EmploymentHistory.all
        render json:records
      end

    end
  end
end

