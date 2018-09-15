class ApplicationHistory < ApplicationRecord
  belongs_to :application

  validates :status, presence: true,
                      uniqueness: { scope: :application_id,
                                    message: "has already been assigned." }

  mount_uploader :document, DocUploader
end
