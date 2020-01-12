class RepresentingInstitution < ApplicationRecord
  enum status: [:active, :inactive]

  has_many :application_institutions
  has_many :applications, through: :application_institutions

  belongs_to :agent
  belongs_to :representing_country
  belongs_to :counsellor, foreign_key: :counsellor_id, optional: true

  mount_uploader :logo, ImageUploader
  audited

  validates :name, :contact_person, :email, :contact, presence: true

  filterrific(
   default_filter_params: { sorted_by: 'created_at_desc' },
   available_filters: [
     :sorted_by,
     :with_name,
     :with_campus,
     :with_status
   ]
 )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("representing_institutions.created_at #{ direction }")
    when /^name_/
      order("LOWER(representing_institutions.name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_name, lambda { |inst_name|
    where(name: inst_name)
  }

  scope :with_campus, lambda { |campus_name|
    where(campus: campus_name)
  }

  scope :with_status, lambda { |status_value|
    where(status: status_value)
  }

  scope :for_agent, -> (agent_id) { where(representing_countries: { agent_id: agent_id }).joins(:representing_country) }
  scope :for_counsellor, -> (counsellor_id) { where(counsellor_id: counsellor_id ) }
  scope :for_country, -> (country_id) { where(representing_country_id: country_id ) }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc']
    ]
  end
end
