class ApplicationInstitution < ApplicationRecord
  belongs_to :application
  belongs_to :representing_institution
end
