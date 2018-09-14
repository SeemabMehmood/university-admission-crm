class ApplicationHistory < ApplicationRecord
  belongs_to :application

  validates :status, presence: true,
                      uniqueness: { message: "has already been assigned." }

  mount_uploader :document, DocUploader
end
