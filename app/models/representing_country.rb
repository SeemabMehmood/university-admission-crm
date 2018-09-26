class RepresentingCountry < ApplicationRecord
  enum status: [:active, :inactive]

  has_many :applications, dependent: :destroy
  has_many :application_processes, dependent: :destroy
  has_many :representing_institutions, dependent: :destroy
  has_many :followups, dependent: :destroy

  belongs_to :agent

  validates :name, :agent_id, presence: true

  accepts_nested_attributes_for :application_processes
  audited

  filterrific(
     default_filter_params: { sorted_by: 'created_at_desc' },
     available_filters: [
       :sorted_by,
       :with_name,
       :with_agent,
       :with_status
     ]
   )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("representing_countries.created_at #{ direction }")
    when /^name_/
      order("LOWER(representing_countries.name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_name, lambda { |country|
    where(name: country)
  }

  scope :with_agent, lambda { |agent_id|
    where(agent_id: agent_id)
  }

  scope :with_status, lambda { |status_value|
    where(status: status_value)
  }

  scope :for_agent, -> (agent_id) { where(agent_id: agent_id) }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc']
    ]
  end

  def get_statuses
    self.application_processes.order(:serial).pluck(:name)
  end

  def branch_officer
    agent.branch_officers.where(country: self.name).last
  end

  def branch_officers
    agent.branch_officers.where(country: self.name)
  end
end
