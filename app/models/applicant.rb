class Applicant < ApplicationRecord
  belongs_to :application

  validates :first_name, :last_name, :dob, :title, :gender,
            :marital_status, :nationality, :phone_num,
            :phone_code, :phone_cc, :email, presence: true

  MARITAL_STATUS = ["Single", "Married", "Divorced", "Widowed", "Other"]
  GENDER         = ["Male", "Female"]
  TITLE          = ["Mr.", "Mrs.", "Ms.", "Other"]
end
