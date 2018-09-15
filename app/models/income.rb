class Income < ApplicationRecord
  belongs_to :application

  validates :date, :total_amount, presence: true

  audited
end
