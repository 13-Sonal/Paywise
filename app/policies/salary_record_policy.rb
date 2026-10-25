# Who may see and change salaries.
class SalaryRecordPolicy
  VIEWER_ROLES = [ Role::ADMIN, Role::HR_MANAGER, Role::HR ].freeze
  EDITOR_ROLES = [ Role::ADMIN, Role::HR_MANAGER ].freeze

  def initialize(user)
    @user = user
  end

  def index?
    @user.has_role?(*VIEWER_ROLES)
  end

  def update?
    @user.has_role?(*EDITOR_ROLES)
  end
end
