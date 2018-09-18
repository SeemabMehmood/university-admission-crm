class Forward < ApplicationRecord
  belongs_to :application

  validates :sender_name, :sender_email, :reciever_name, :reciever_email, presence: true

  after_create :send_forward_email

  mount_uploader :attachment, DocUploader
  audited

  def by_user
    User.find(self.audits.last.user_id).name.titleize
  end

  private

  def send_forward_email
    ApplicantMailer.forward(self.sender_name, self.sender_email,
                            self.reciever_name, self.reciever_email,
                            self.message, self.attachment, self.application).deliver_now
  end
end
