class Counsellor < User
  belongs_to :branch_officer

  def subordinate_count
    "Applications count"
  end
end
