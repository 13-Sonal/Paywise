require "rails_helper"

RSpec.describe SalaryRecordSerializer do
  let(:salary_record) { create(:salary_record) }

  it "includes the pay details and the role" do
    expect(described_class.new(salary_record).as_json).to include(
      id: salary_record.id,
      user_id: salary_record.user_id,
      compensation: salary_record.compensation,
      currency: "INR",
      effective_from: Date.new(2026, 4, 1),
      role: { id: salary_record.role.id, name: salary_record.role.name }
    )
  end

  it "serialises a collection" do
    expect(described_class.collection([ salary_record ])).to contain_exactly(
      include(id: salary_record.id)
    )
  end
end
