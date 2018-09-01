class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.agent?
      can [:read, :update], User, id: user.id
      can [:read, :update], User, agent_id: user.id
      can [:create, :update, :change_status], BranchOfficer, agent_id: user.id
    elsif user.branch_officer?
      can [:read, :update], User, id: user.id
      can [:read, :update], User, branch_officer_id: user.id
      can [:create, :update, :change_status], Counsellor, branch_officer_id: user.id
    elsif user.counsellor?
      can [:read, :update], User, id: user.id
    end

    #   can :update, Article, :published => true
  end
end
