class Application < ApplicationRecord
  belongs_to :representing_country
  belongs_to :representing_institution
  belongs_to :counsellor, foreign_key: :counsellor_id, optional: true
  belongs_to :branch_officer, foreign_key: :branch_officer_id, optional: true
  belongs_to :agent, foreign_key: :agent_id

  has_one :applicant, inverse_of: :application, dependent: :destroy
  has_many :application_histories, dependent: :destroy
  has_many :admin_notes, dependent: :destroy
  has_many :forwards, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_one :income, dependent: :destroy

  validates :course_name, :intake_year, :intake_month, :interview_date, presence: true

  after_create :set_reference_no

  accepts_nested_attributes_for :applicant, :income

  audited

  mount_uploader :additional_document, DocUploader
  mount_uploader :statement_of_purpose_doc, DocUploader

  INTAKE_YEARS = Date.today.year..Date.today.year + 8
  INTAKE_MONTHS = Date::MONTHNAMES.compact

  filterrific(
   default_filter_params: { sorted_by: 'created_at_desc' },
   available_filters: [
     :sorted_by,
     :with_course_name,
     :with_intake_month,
     :with_intake_year,
     :with_reference_no
   ]
 )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("applications.created_at #{ direction }")
    when /^course_name_/
      order("LOWER(applications.course_name) #{ direction }")
    when /^reference_no_/
      order("LOWER(applications.reference_no) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_course_name, lambda { |inst_course_name|
    where(course_name: inst_course_name)
  }

  scope :with_intake_month, lambda { |intake_month|
    where(intake_month: intake_month)
  }

  scope :with_intake_year, lambda { |intake_year|
    where(intake_year: intake_year)
  }

  scope :with_reference_no, lambda { |reference_no|
    where(reference_no: reference_no)
  }

  scope :for_agent, -> (agent_id) { where(agent_id: agent_id) }
  scope :for_branch_officer, -> (branch_officer_id) { where(branch_officer_id: branch_officer_id) }
  scope :for_counsellor, -> (counsellor_id) { where(counsellor_id: counsellor_id) }

  def self.options_for_sorted_by
    [
      ['Course Name (a-z)', 'course_name_asc'],
      ['Reference No', 'reference_no_asc']
    ]
  end

  def intake
    [intake_month, intake_year].join(", ")
  end

  def country
    representing_country.name
  end

  def institute
    representing_institution.name
  end

  def build_applicant_data
    self.applicant = Applicant.new(application_id: self.id)
    self.income = Income.new(application_id: self.id)
    self.applicant.educations.build
    self.applicant.languages.build
    self.applicant.work_experiences.build
    self.applicant.references.build
  end

  def current_status
    return "Unconditional" unless self.application_histories.present?
    self.application_histories.last.status
  end

  def self.for_user(user)
    if user.agent?
      self.for_agent(user.id)
    elsif user.branch_officer?
      self.for_branch_officer(user.id)
    elsif user.counsellor?
      self.for_counsellor(user.id)
    end
  end

  private

  def set_reference_no
    user = User.find(self.agent_id)
    self.reference_no = [user.name[0].upcase, user.id,
                         self.representing_country.name[0].upcase, self.id,
                         self.applicant.name[0].upcase,
                         self.created_at.strftime("%d%m%Y") ].join()
    self.income.update_attributes(date: self.created_at.strftime("%d-%m-%Y")) if self.income.present?
    self.save!
  end

end
