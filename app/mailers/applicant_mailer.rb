class ApplicantMailer < ApplicationMailer
  def forward(sender_name, sender_email, reciever_name, reciever_email, message, attachment)
    @sender_name = sender_name
    @reciever_name = reciever_name
    @message = message
    if attachment.present?
      @filename = attachment.filename
      attachments.inline[attachment.filename] = File.read([Rails.root, "/public", attachment.url].join)
    end
    mail to: reciever_email, from: sender_email, subject: ["You have recieved a message from", sender_name.titleize].join(" ")
  end

  def reminder(sender_name, sender_email, reciever_name, reciever_email, message, attachment)
    @sender_name = sender_name
    @reciever_name = reciever_name
    @message = message
    if attachment.present?
      @filename = attachment.filename
      attachments.inline[attachment.filename] = File.read([Rails.root, "/public", attachment.url].join)
    end
    mail to: reciever_email, from: sender_email, subject: ["This is a reminder email from", sender_name.titleize].join(" ")
  end
end
