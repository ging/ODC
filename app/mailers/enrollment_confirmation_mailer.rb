class EnrollmentConfirmationMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.enrollment_confirmation_mailer.enrollment_confirmation.subject
  #
  def enrollment_confirmation(email, username, course, url, offset_orig, offset)
	@course = course
	@username = username
	@url = url
	@offset_orig = offset_orig
	@offset = offset
	mail(to: email, subject: t("course.email_subject") + '"' + course.name + '"', encrypt: true)
  end
end
