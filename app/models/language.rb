class Language < ApplicationRecord
  belongs_to :applicant

  mount_uploader :scanned_doc, DocUploader

  validates :test_type, uniqueness: true

  TYPE = ["IELTS", "TOEFL", "PTE", "GMAT", "Other"]
end
