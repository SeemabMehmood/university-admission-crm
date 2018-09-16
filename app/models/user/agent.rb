class Agent < User
  has_many :branch_officers, foreign_key: :agent_id
  has_many :representing_countries, foreign_key: :agent_id
  has_many :representing_institutions, foreign_key: :agent_id
  has_many :applications, foreign_key: :agent_id

  def subordinate_count
    [branch_officers.count, " BO's"].join
  end
end
