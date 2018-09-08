class RepresentingInstitution < ApplicationRecord
  belongs_to :representing_countries
  belongs_to :counsellors

  validates :name, :contact_person, :email, :contact, presence: true
end
