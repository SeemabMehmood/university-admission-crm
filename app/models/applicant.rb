class Applicant < ApplicationRecord
  belongs_to :application

  has_many :addresses
  has_many :educations
  has_many :languages
  has_many :work_experiences
  has_many :references

  validates :first_name, :last_name, :dob, :title, :gender,
            :marital_status, :nationality, :phone_num,
            :phone_code, :phone_cc, :email, presence: true

  MARITAL_STATUS = ["Single", "Married", "Divorced", "Widowed", "Other"]
  GENDER         = ["Male", "Female"]
  TITLE          = ["Mr.", "Mrs.", "Ms.", "Other"]
end
