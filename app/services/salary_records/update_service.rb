module SalaryRecords
  # Changes the pay details of one salary record and logs the new pay as an
  # employment history entry. Both are saved together, or neither is.
  class UpdateService < ApplicationService
    COMPANY_NAME = "Current Company".freeze

    def initialize(salary_record:, attributes:)
      @salary_record = salary_record
      @attributes = attributes
    end

    def call
      employment_history = ActiveRecord::Base.transaction do
        @salary_record.update!(@attributes)
        create_employment_history!
      end

      ServiceResult.success(salary_record: @salary_record, employment_history: employment_history)
    rescue ActiveRecord::RecordInvalid => error
      ServiceResult.failure(error.record.errors.full_messages)
    end

    private

    def create_employment_history!
      EmploymentHistory.create!(
        user_id: @salary_record.user_id,
        company_name: COMPANY_NAME,
        designation: @salary_record.role&.name&.strip,
        salary: @salary_record.compensation,
        currency: @salary_record.currency,
        started_on: @salary_record.effective_from,
        ended_on: nil
      )
    end
  end
end
