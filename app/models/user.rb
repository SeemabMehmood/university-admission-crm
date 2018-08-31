class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable

  enum role: [:admin, :agent, :branch_officer, :consellor]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :admin
  end
end
