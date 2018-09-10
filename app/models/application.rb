class Application < ApplicationRecord
  belongs_to :representing_country
  belongs_to :representing_institution
  belongs_to :counsellor, foreign_key: :user_id

  validates :course_name, :intake_year, :intake_month, presence: true

  after_create :set_reference_no

  private

  def set_reference_no
    self.reference_no = [self.counsellor.name[0].upcase, self.counsellor.id,
                         self.representing_country.name[0].upcase, self.id,
                         self.counsellor.branch_officer.name[0].upcase,
                         self.created_at.strftime("%d%m%Y") ].join()
  end

end
