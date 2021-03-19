class NewsletterMailer < ApplicationMailer
  def newsletter_email(to, subject, body)
    mail(to: to,
         body: body,
         content_type: "text/html",
         subject: subject)
  end
end