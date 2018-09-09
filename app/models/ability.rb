class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.present?
      if user.admin?
        can :manage, :all

      elsif user.agent?
        can :manage, EmailTemplate
        can :manage, ApplicationProcess
        can :manage, RepresentingCountry
        can :manage, RepresentingInstitution
        can :manage, User, agent_id: user.id

        can [:read, :edit, :update], User, id: user.id
      elsif user.branch_officer?
        can :manage, RepresentingInstitution
        can :read, RepresentingCountry
        can :manage, User, branch_officer_id: user.id

        can [:read, :edit, :update], User, id: user.id
      elsif user.counsellor?
        can [:read], RepresentingInstitution
        can [:read, :edit, :update], User, id: user.id
      end
    end
  end
end
