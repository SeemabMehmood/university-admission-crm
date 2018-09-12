class Language < ApplicationRecord
  belongs_to :applicant

  mount_uploader :scanned_doc, DocUploader

  TYPE = ["IELTS", "TOEFL", "PTE", "GMAT", "Other"]
end
