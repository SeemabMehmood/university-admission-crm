class Reminder < ApplicationRecord
  belongs_to :application

  mount_uploader :attachment, DocUploader
end
