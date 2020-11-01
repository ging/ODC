# Preview all emails at http://localhost:3000/rails/mailers/enrollment_confirmation_mailer
class EnrollmentConfirmationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/enrollment_confirmation_mailer/enrollment_confirmation
  def enrollment_confirmation
    EnrollmentConfirmationMailer.enrollment_confirmation
  end

end
