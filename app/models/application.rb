class Application < ApplicationRecord
  belongs_to :representing_country
  belongs_to :representing_institution
  belongs_to :counsellor, foreign_key: :counsellor_id

  has_one :applicant
  has_many :application_histories
  has_many :admin_notes
  has_many :forwards
  has_many :reminders

  validates :course_name, :intake_year, :intake_month, presence: true

  after_create :set_reference_no

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

  def self.options_for_sorted_by
    [
      ['Course Name (a-z)', 'course_name_asc'],
      ['Reference No', 'reference_no_asc']
    ]
  end

  def intake
    [intake_month, intake_year].join(", ")
  end

  private

  def set_reference_no
    self.reference_no = [self.counsellor.name[0].upcase, self.counsellor.id,
                         self.representing_country.name[0].upcase, self.id,
                         self.counsellor.branch_officer.name[0].upcase,
                         self.created_at.strftime("%d%m%Y") ].join()
    self.save!
  end

end
