class ApplicationProcess < ApplicationRecord
  enum status: [:active, :inactive]

  belongs_to :representing_country

  has_one :email_template

  validates :name, :serial, presence: true

  default_scope { order(serial: :asc) }
end
