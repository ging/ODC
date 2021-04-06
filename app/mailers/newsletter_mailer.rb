class NewsletterMailer < ApplicationMailer

  def newsletter_email(to, subject, body)
    # mail(to: to,
    #      body: body,
    #      content_type: "text/html",
    #      subject: subject)
    #TODO

    puts "Newsletter mailer"
    puts to
    puts subject
    puts body
  end

end