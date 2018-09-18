class Income < ApplicationRecord
  belongs_to :application

  validates :date, :total_amount, presence: true

  scope :for_user, -> (user_id) { where(applications: {agent_id: user_id}).includes(:application) }

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
