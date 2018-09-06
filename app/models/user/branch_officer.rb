class BranchOfficer < User
  has_many :counsellors, foreign_key: :branch_officer_id
  belongs_to :agent

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
     :sorted_by,
     :with_role,
     :with_country
    ]
  )

  def representing_country
    agent.representing_countries.where(name: country).last
  end

  def subordinate_count
    [counsellors.count, " Counsellors"].join
  end
end
