module Api
  module V1
    class SalaryRecordsController < ApplicationController
      SALARY_EDITOR_ROLES = ["Admin", "HR Manager"].freeze

      before_action :authorize_salary_editor, only: [:update]

      def index
        records = SalaryRecord.includes(:role)

        render json: records.as_json(
          include: {
            role: {
              only: [:id, :name]
            }
          }
        )
      end
      def update
        salary_record = SalaryRecord.find(params[:id])

        previous_values = salary_record.attributes.slice(
          "compensation",
          "currency",
          "effective_from"
        )

        SalaryRecord.transaction do
          unless salary_record.update(salary_record_params)
            raise ActiveRecord::Rollback
          end

          EmploymentHistory.create!(
            user_id: salary_record.user_id,
            company_name: "Current Company",
            designation: salary_record.role&.name&.strip,
            salary: salary_record.compensation,
            currency: salary_record.currency,
            started_on: salary_record.effective_from,
            ended_on: nil
          )
        end

        if salary_record.errors.empty?
          render json: {
            message: "Salary record updated and employment history created successfully",
            salary_record: salary_record,
            employment_history: EmploymentHistory.where(
              user_id: salary_record.user_id
            ).order(created_at: :desc).first
          }, status: :ok
        else
          render json: {
            errors: salary_record.errors.full_messages
          }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: {
          error: "Salary record not found"
        }, status: :not_found
      rescue ActiveRecord::RecordInvalid => error
        render json: {
          errors: error.record.errors.full_messages
        }, status: :unprocessable_entity
      end


      
      private

      def authorize_salary_editor
        return if SALARY_EDITOR_ROLES.include?(
          current_user.role&.name&.strip
        )

        render json: {
          error: "You don't have permission to update salaries"
        }, status: :forbidden
      end

      def salary_record_params
        params.require(:salary_record).permit(
          :compensation,
          :currency,
          :effective_from
        )
      end
    end
  end
end
