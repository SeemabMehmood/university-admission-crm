class Agent < User
  has_many :branch_officers, foreign_key: :agent_id

  def subordinate_count
    [branch_officers.count, " BO's"].join
  end
end
