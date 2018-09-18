class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.present?
      if user.admin?
        can :manage, :all
        cannot :manage, Application
        cannot :manage, Income
        cannot :manage, Expense

      elsif user.agent?
        can :manage, EmailTemplate
        can :manage, ApplicationProcess
        can :manage, RepresentingCountry
        can :manage, RepresentingInstitution
        can :manage, User, agent_id: user.id
        can :manage, Application
        can :manage, Income
        can :manage, Expense

        can [:read, :edit, :update], User, id: user.id
      elsif user.branch_officer?

        can :manage, Application
        can :edit, :update, Income, application: { branch_officer_id: user.id }
        can [:read, :assign_institutions,
            :manage_counsellor, :get_institutions_from_country], RepresentingInstitution, agent_id: user.agent.id
        can :read, RepresentingCountry, agent_id: user.agent.id
        can :manage, User, branch_officer_id: user.id

        can [:read, :edit, :update], User, id: user.id
      elsif user.counsellor?
        can :manage, Application
        can :edit, :update, Income, application: { counsellor_id: user.id }

        can :read, RepresentingCountry, agent_id: user.branch_officer.agent.id
        can :get_institutions_from_country, RepresentingInstitution
        can [:read], RepresentingInstitution, counsellor_id: user.id
        can [:read, :edit, :update], User, id: user.id
      end
    end
  end
end
