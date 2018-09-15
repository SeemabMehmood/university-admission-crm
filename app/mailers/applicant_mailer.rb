class ApplicantMailer < ApplicationMailer
  def forward(user, message)
    @greeting = "Hi"
    @user = user
    @message = message
    mail to: "to@example.com"
  end
end
