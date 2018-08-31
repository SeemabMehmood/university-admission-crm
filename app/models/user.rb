class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable

  enum status: [:active, :inactive]
  enum role:   [:admin, :agent, :branch_officer, :consellor]
end
