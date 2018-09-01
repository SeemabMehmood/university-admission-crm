class Counsellor < User
  belongs_to :branch_officer, foreign_key: :branch_officer_id

  def subordinate_count
    "Applications count"
  end
end
