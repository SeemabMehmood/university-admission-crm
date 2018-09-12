class ApplicationHistory < ApplicationRecord
  belongs_to :applications

  mount_uploader :document, DocUploader
end
