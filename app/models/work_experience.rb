class WorkExperience < ApplicationRecord
  belongs_to :applicant

  mount_uploader :scanned_doc, DocUploader
end
