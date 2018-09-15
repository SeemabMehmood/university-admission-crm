class Reminder < ApplicationRecord
  belongs_to :application

  mount_uploader :attachment, DocUploader

  audited

  def by_user
    User.find(self.audits.last.user_id).name.titleize
  end
end
