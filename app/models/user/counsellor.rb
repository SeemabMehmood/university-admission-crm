class Counsellor < User
  belongs_to :branch_officer

  scope :for_agent, -> (user_id) { includes(:branch_officer).where(users: { agent_id: user_id }) }

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
     :sorted_by,
     :with_role,
     :with_country_name
    ]
  )

  def subordinate_count
    "Applications count"
  end
end
