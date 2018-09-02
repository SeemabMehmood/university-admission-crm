class BranchOfficer < User
  has_many :counsellors, foreign_key: :branch_officer_id

  belongs_to :agent

  def subordinate_count
    [counsellors.count, " Counsellors"].join
  end
end
