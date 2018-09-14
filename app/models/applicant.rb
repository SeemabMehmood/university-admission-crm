class Applicant < ApplicationRecord
  belongs_to :application, inverse_of: :applicant

  has_many :addresses
  has_many :educations
  has_many :languages
  has_many :work_experiences
  has_many :references

  validates :first_name, :last_name, :dob, :title, :gender,
            :marital_status, :nationality, :phone_num,
            :phone_code, :phone_cc, :email, presence: true

  validates :application, presence: true

  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :languages
  accepts_nested_attributes_for :work_experiences
  accepts_nested_attributes_for :references

  MARITAL_STATUS = ["Single", "Married", "Divorced", "Widowed", "Other"]
  GENDER         = ["Male", "Female"]
  TITLE          = ["Mr.", "Mrs.", "Ms.", "Other"]

  def name
    [first_name, last_name].join(" ")
  end

  def phone_number
    [phone_cc, phone_code, phone_num].join(" - ")
  end

  def mobile_number
    [mobile_cc, mobile_code, mobile_num].join(" - ")
  end
end
