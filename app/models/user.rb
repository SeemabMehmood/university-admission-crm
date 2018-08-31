class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, :trackable

  enum status: [:active, :inactive]
  enum role:   [:admin, :agent, :branch_officer, :counsellor]

  scope :branch_officers, -> { where(role: 2) }
  scope :counsellors,     -> { where(role: 3) }
  scope :agents,          -> { where(role: 1) }

  def self.get_users_by_role(current_user)
    return branch_officers if current_user.agent?
    return counsellors     if current_user.branch_officer?
    all                    if current_user.admin?
  end

end
