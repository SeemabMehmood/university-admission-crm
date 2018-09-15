class Expense < ApplicationRecord
  audited

  validates :date, :reason, presence: true
end
