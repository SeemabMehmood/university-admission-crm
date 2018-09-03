class BranchOfficer < User
  has_many :counsellors, foreign_key: :branch_officer_id

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
     :sorted_by,
     :with_role,
     :with_country_name
    ]
 )

  belongs_to :agent

  def subordinate_count
    [counsellors.count, " Counsellors"].join
  end
end
