class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, :trackable

  enum status: [:active, :inactive]
  enum role:   [:admin, :agent, :branch_officer, :counsellor]

  after_initialize :setup_password

  scope :branch_officers, -> { where(role: 2) }
  scope :counsellors,     -> { where(role: 3) }
  scope :agents,          -> { where(role: 1) }

  def self.get_users_by_role(current_user)
    return branch_officers if current_user.agent?
    return counsellors     if current_user.branch_officer?
    all                    if current_user.admin?
  end

  def self.build_for_role(current_user)
    return new(role: 1) if current_user.admin?
    return new(role: 2) if current_user.agent?
    return new(role: 3) if current_user.branch_officer?
  end

  private

  def setup_password
    return if self.persisted?
    self.password = self.password_confirmation = Devise.friendly_token.first(8)
  end
end
