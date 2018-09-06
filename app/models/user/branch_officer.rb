class BranchOfficer < User
  has_many :counsellors, foreign_key: :branch_officer_id
  belongs_to :agent

  belongs_to :representing_country, foreign_key: "country"

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
     :sorted_by,
     :with_role,
     :with_country_name
    ]
 )

  def subordinate_count
    [counsellors.count, " Counsellors"].join
  end
end
