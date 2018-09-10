class ApplicationProcess < ApplicationRecord
  enum status: [:active, :inactive]

  belongs_to :representing_country

  has_one :email_template

  validates :name, :serial, presence: true

  default_scope { order(serial: :asc) }

  before_save :check_if_serial_unique

  private

    def check_if_serial_unique
      if representing_country.application_processes.pluck(:serial).include?(self.serial)
        errors.add(:base, "cannot have duplicate serial nunbers.")
      end
    end
end
