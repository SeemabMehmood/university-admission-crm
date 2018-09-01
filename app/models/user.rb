class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, :trackable

  enum status: [:active, :inactive]

  after_initialize :setup_password

  validates :name, :country, presence: true

  def self.get_users_by_role(current_user)
    return branch_officers if current_user.agent?
    return counsellors     if current_user.branch_officer?
    all                    if current_user.admin?
  end

  def street_address
    [street, city].join(', ') if street && city
  end

  def state_address
    return country unless state && zipcode
    [[zipcode, state].join(' - '), country].join(' | ')
  end

  private

  def setup_password
    return if self.persisted?
    self.password = self.password_confirmation = Devise.friendly_token.first(8)
  end
end
