class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.present?
      if user.admin?
        can :manage, :all
        cannot :manage, Application

      elsif user.agent?
        can :manage, EmailTemplate
        can :manage, ApplicationProcess
        can :manage, RepresentingCountry
        can :manage, RepresentingInstitution
        can :manage, User, agent_id: user.id

        can [:read, :edit, :update], User, id: user.id
      elsif user.branch_officer?
        can :manage, RepresentingInstitution
        can :read, RepresentingCountry, agent_id: user.agent.id
        can :manage, User, branch_officer_id: user.id

        can [:read, :edit, :update], User, id: user.id
      elsif user.counsellor?
        can :manage, Application

        can :read, RepresentingCountry, agent_id: user.branch_officer.agent.id
        can [:read], RepresentingInstitution, user_id: user.id
        can [:read, :edit, :update], User, id: user.id
      end
    end
  end
end
