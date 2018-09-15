# Preview all emails at http://localhost:3000/rails/mailers/applicant_mailer
class ApplicantMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/applicant_mailer/forward
  def feedback
    ApplicantMailer.forward("kiran", "kiran@gmail.com", "raghav", "raghav@gmail.com",
      "Hello we are here for you. We are going to forward an application to you. Please read and respond")
  end

end
