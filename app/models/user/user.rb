class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, :trackable

  enum status: [:active, :inactive]

  after_initialize :setup_password

  validates :name, :country, presence: true

  ROLES = ["admin", "agent", "branch_officer", "counsellor"]

  def street_address
    [street, city].join(', ') if street && city
  end

  def state_address
    return country unless state && zipcode
    [[zipcode, state].join(' - '), country].join(' | ')
  end

  def role
    type.present? ? type : "admin"
  end

  def admin?
    type.nil? || type.empty?
  end

  def agent?
    type == 'Agent'
  end

  def branch_officer?
    type == 'BranchOfficer'
  end

  def counsellor?
    type == 'Counsellor'
  end

  def build_user
    return BranchOfficer.new if self.agent?
    return Counsellor.new    if self.branch_officer?
  end

  private

  def setup_password
    return if self.persisted?
    self.password = self.password_confirmation = Devise.friendly_token.first(8)
  end
end
