class Income < ApplicationRecord
  belongs_to :application, optional: true
  belongs_to :agent, optional: true

  validates :date, :total_amount, presence: true

  scope :for_user, -> (user_id) { where(applications: {agent_id: user_id}).or(Income.where(agent_id: user_id)).includes(:application) }
  scope :by, -> (user_id) { where(created_by: user_id) }

  audited

  filterrific(
    default_filter_params: {},
    available_filters: [
      :with_date,
      :with_application
     ]
   )

  scope :with_date, lambda { |date|
    where(date: date)
  }

  scope :with_application, lambda { |application_id|
    where(application_id: application_id)
  }

  def self.get_incomes_for(user)
    return for_user(user.id) if user.agent?
    by(user.id)
  end

  def paid
    self.total_amount.to_f - self.remaining_balance.to_f
  end

  def updated_by_name
    User.find(self.audits.last.user_id).name.titleize
  end

  def updated_by_id
    self.audits.last.user_id
  end
end
