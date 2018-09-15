class ApplicantMailer < ApplicationMailer
  def forward(sender_name, sender_email, reciever_name, reciever_email, message)
    @sender_name = sender_name
    @reciever_name = reciever_name
    @message = message
    mail to: reciever_email, from: sender_email, subject: ["You have recieved a message from", sender_name.titleize].join(" ")
  end
end
