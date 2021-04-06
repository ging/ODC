require 'sendgrid-ruby'
include SendGrid

class NewsletterMailer < ApplicationMailer

  def newsletter_email(to, subject, body)
    return false if to.blank? or subject.blank? or body.blank? or ODC::Application.config.APP_CONFIG["no_reply_mail"].blank? or ODC::Application.config.APP_CONFIG["mail"].blank? or ODC::Application.config.APP_CONFIG["mail"]["password"].blank?
    return false unless ODC::Application.config.action_mailer.perform_deliveries == true

    recipients = to.split(";");
    chunks = recipients.each_slice(999)
    responses = []
    chunks.each do |chunk|
        responses.push(newsletter_email_chunk(chunk, subject, body))
    end
    return (responses.length > 0 and responses.select{|r| r.status_code != "202"}.length == 0)
  end

  def newsletter_email_chunk(to, subject, body)
    mail = SendGrid::Mail.new
    mail.from = Email.new(email: ODC::Application.config.APP_CONFIG["no_reply_mail"])
    mail.subject = subject

    personalization = Personalization.new
    personalization.add_to(Email.new(email: ODC::Application.config.APP_CONFIG["main_mail"]))

    to.first(999).each do |recipientMail|
        personalization.add_bcc(Email.new(email: recipientMail))
    end
    mail.add_personalization(personalization)

    mail.add_content(Content.new(type: 'text/html', value: body))

    sg = SendGrid::API.new(api_key: ODC::Application.config.APP_CONFIG["mail"]["password"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    return response
  end

end