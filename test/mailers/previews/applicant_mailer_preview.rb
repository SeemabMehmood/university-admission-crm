# Preview all emails at http://localhost:3000/rails/mailers/applicant_mailer
class ApplicantMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/applicant_mailer/forward
  def feedback
    user = User.last
    message = "Test message."
    ApplicantMailer.forward(user, message)
  end

end