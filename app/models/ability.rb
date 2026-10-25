class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    case user.role.name
    when "Admin"
      can :manage, :all

    when "HR Manager"
      can :read, Employee
      can :manage, Assessment

    when "HR"
      can :read, Employee
      can :read, Assessment
    end
  end
end
