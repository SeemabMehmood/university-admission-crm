class Expense < ApplicationRecord
  belongs_to :agent
  audited

  validates :date, :reason, presence: true

  scope :for_agent, -> (agent_id) { where(agent_id: agent_id) }

  filterrific(
    default_filter_params: {},
    available_filters: [
      :with_date
     ]
   )

  scope :with_date, lambda { |date|
    where(date: date)
  }

end
