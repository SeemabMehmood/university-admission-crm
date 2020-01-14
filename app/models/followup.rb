class Followup < ApplicationRecord
  has_one :applicant, inverse_of: :application, dependent: :destroy
  belongs_to :agent, foreign_key: :agent_id
  belongs_to :representing_country

  enum status: [:active, :inactive]

  mount_uploader :additional_document, DocUploader

  accepts_nested_attributes_for :applicant

  audited

  filterrific(
   default_filter_params: { sorted_by: 'created_at_desc' },
   available_filters: [
     :sorted_by,
     :with_date
   ]
 )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("followups.created_at #{ direction }")
    when /^date_/
      order("followups.date #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_date, lambda { |date|
    where(date: date)
  }

  def self.options_for_sorted_by
    [
      ['Date (ASC)', 'date_asc']
    ]
  end

  scope :for_agent, -> (agent_id) { where(agent_id: agent_id) }

  def by_user
    User.find(self.audits.last.user_id).name.titleize
  end

  def build_applicant_data
    self.applicant = Applicant.new(followup_id: self.id)
    self.applicant.educations.build
    self.applicant.languages.build
    self.applicant.work_experiences.build
    self.applicant.references.build
  end
end
