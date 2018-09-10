class Counsellor < User
  has_many :representing_institutions, foreign_key: :user_id
  has_many :applications, foreign_key: :user_id

  belongs_to :branch_officer

  scope :for_agent, -> (user_id) { includes(:branch_officer).where(users: { agent_id: user_id }) }

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
     :sorted_by,
     :with_role,
     :with_country
    ]
  )

  def subordinate_count
    "Applications count"
  end

  def institution_assigned?(institution_id)
    self.representing_institutions.active.pluck(:id).include?(institution_id)
  end

  def agent
    branch_officer.agent
  end
end
