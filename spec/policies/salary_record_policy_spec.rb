require "rails_helper"

RSpec.describe SalaryRecordPolicy do
  subject(:policy) { described_class.new(user) }

  {
    admin: { index: true, update: true },
    hr_manager: { index: true, update: true },
    hr: { index: true, update: false }
  }.each do |role, allowed|
    context "when the user is #{role.to_s.humanize}" do
      let(:user) { build(:user, role) }

      it { expect(policy.index?).to be(allowed[:index]) }
      it { expect(policy.update?).to be(allowed[:update]) }
    end
  end

  context "when the user has any other role" do
    let(:user) { build(:user) }

    it { expect(policy.index?).to be(false) }
    it { expect(policy.update?).to be(false) }
  end
end
