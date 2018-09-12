class Address < ApplicationRecord
  belongs_to :applicant

  validates :city, :address, :country, presence: true
end
