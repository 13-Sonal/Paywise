require "rails_helper"

RSpec.describe SalaryRecords::UpdateService do
  subject(:result) { described_class.call(salary_record: salary_record, attributes: attributes) }

  let(:salary_record) { create(:salary_record, compensation: 85_000, currency: "INR") }

  context "with valid attributes" do
    let(:attributes) { { compensation: 120_000, currency: "USD", effective_from: "2026-10-01" } }

    it "succeeds and returns the updated record" do
      expect(result).to be_success
      expect(result.data[:salary_record]).to eq(salary_record)
      expect(result.errors).to be_empty
    end

    it "saves the changes" do
      result

      expect(salary_record.reload).to have_attributes(
        compensation: 120_000,
        currency: "USD",
        effective_from: Date.new(2026, 10, 1)
      )
    end

    it "creates an employment history entry with the new pay" do
      expect { result }.to change(EmploymentHistory, :count).by(1)

      expect(result.data[:employment_history]).to have_attributes(
        user_id: salary_record.user_id,
        company_name: described_class::COMPANY_NAME,
        designation: salary_record.role.name,
        salary: 120_000,
        currency: "USD",
        started_on: Date.new(2026, 10, 1),
        ended_on: nil
      )
    end
  end

  context "with invalid attributes" do
    let(:attributes) { { compensation: 0 } }

    it "fails with the validation messages" do
      expect(result).not_to be_success
      expect(result.data).to be_empty
      expect(result.errors).to contain_exactly("Compensation must be greater than 0")
    end

    it "leaves the record unchanged and creates no employment history" do
      expect { result }.not_to change(EmploymentHistory, :count)

      expect(salary_record.reload.compensation).to eq(85_000)
    end
  end

  context "when the employment history can't be saved" do
    let(:attributes) { { compensation: 120_000 } }

    before do
      allow(EmploymentHistory).to receive(:create!).and_raise(ActiveRecord::RecordInvalid.new(EmploymentHistory.new))
    end

    it "rolls back the salary change" do
      expect(result).not_to be_success
      expect(salary_record.reload.compensation).to eq(85_000)
    end
  end
end
