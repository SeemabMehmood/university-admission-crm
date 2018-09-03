class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.present?
      if user.admin?
        can :manage, :all
      elsif user.agent?
        can :new, User
        can [:read, :edit, :update], User, id: user.id
        can [:read, :create, :update, :change_status], BranchOfficer, agent_id: user.id
      elsif user.branch_officer?
        can :new, User
        can [:read, :edit, :update], User, id: user.id
        can [:read, :create, :edit, :update, :change_status], Counsellor, branch_officer_id: user.id
      elsif user.counsellor?
        can [:read, :edit, :update], User, id: user.id
      end
    end

    #   can :update, Article, :published => true
  end
end
