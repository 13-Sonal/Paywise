require "rails_helper"

RSpec.describe User, type: :model do
  describe "#role_name" do
    it "ignores stray whitespace in the stored role name" do
      user = build(:user, role: build(:role, name: " HR Manager "))

      expect(user.role_name).to eq(Role::HR_MANAGER)
    end
  end

  describe "#has_role?" do
    let(:user) { build(:user, :hr) }

    it "is true when the user has one of the given roles" do
      expect(user.has_role?(Role::ADMIN, Role::HR)).to be(true)
    end

    it "is false otherwise" do
      expect(user.has_role?(Role::ADMIN, Role::HR_MANAGER)).to be(false)
    end
  end
end
