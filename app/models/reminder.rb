class Reminder < ApplicationRecord
  belongs_to :application

  validates :sender_name, :sender_email, :reciever_name, :reciever_email, presence: true

  mount_uploader :attachment, DocUploader

  audited

  def by_user
    User.find(self.audits.last.user_id).name.titleize
  end
end
