require "rails_helper"

RSpec.describe SalaryRecord, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:role) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:compensation) }
    it { is_expected.to validate_numericality_of(:compensation).is_greater_than(0) }
  end
end
