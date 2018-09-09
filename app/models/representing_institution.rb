class RepresentingInstitution < ApplicationRecord
  enum status: [:active, :inactive]

  belongs_to :representing_country
  belongs_to :counsellor, foreign_key: :user_id, optional: true

  mount_uploader :logo, ImageUploader

  validates :name, :contact_person, :email, :contact, presence: true

  filterrific(
   default_filter_params: { sorted_by: 'created_at_desc' },
   available_filters: [
     :sorted_by,
     :with_name,
     :with_campus
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

  scope :for_agent, -> (agent_id) { where(representing_country: { agent_id: agent_id }) }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc']
    ]
  end

  def agent
    self.representing_country.agent
  end

  def branch_officer
    self.representing_country.branch_officer
  end
end
