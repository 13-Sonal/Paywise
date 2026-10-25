module Api
  module V1
    class EmploymentHistoriesController < ApplicationController
      def index 
        records = EmploymentHistory.all
        render json:records
      end

    end
  end
end

