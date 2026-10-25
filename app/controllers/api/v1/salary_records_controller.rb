module Api
  module V1
    class SalaryRecordsController < ApplicationController
      before_action :authorize_index, only: [ :index ]
      before_action :authorize_update, only: [ :update ]

      def index
        records = SalaryRecord.includes(:role)

        render json: SalaryRecordSerializer.collection(records)
      end

      def update
        result = SalaryRecords::UpdateService.call(
          salary_record: SalaryRecord.find(params.require(:id)),
          attributes: salary_record_params
        )

        if result.success?
          render json: {
            message: "Salary record updated and employment history created successfully",
            salary_record: SalaryRecordSerializer.new(result.data[:salary_record]).as_json,
            employment_history: result.data[:employment_history]
          }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def policy
        @policy ||= SalaryRecordPolicy.new(current_user)
      end

      def authorize_index
        render_forbidden("You don't have permission to view salaries") unless policy.index?
      end

      def authorize_update
        render_forbidden("You don't have permission to update salaries") unless policy.update?
      end

      def salary_record_params
        permitted = params.require(:salary_record).permit(:compensation, :currency, :effective_from)
        raise ActionController::ParameterMissing, :salary_record if permitted.empty?

        permitted
      end
    end
  end
end
