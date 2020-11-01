class EnrollmentConfirmationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enrollment_confirmation_mailer.enrollment_confirmation.subject
  #
  def enrollment_confirmation(email, name,  course)
	@course = course

	mail(to: email, subject: 'Te has apuntado al curso' + course.name, encrypt: true)
  end
end
