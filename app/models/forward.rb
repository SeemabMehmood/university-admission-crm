class Forward < ApplicationRecord
  belongs_to :application

  after_create :send_forward_email

  audited

  def by_user
    User.find(self.audits.last.user_id).name.titleize
  end

  private

  def send_forward_email
    ApplicantMailer.forward(self.sender_name, self.sender_email,
                            self.reciever_name, self.reciever_email,
                            self.message).deliver_now
  end
end
