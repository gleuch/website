class UserMailer < ActionMailer::Base

  default from: "gleu.ch <hello@gleu.ch>"
  default to: "dev@gleu.ch"

  # layout 'layouts/mail'
  helper MailerHelper


  def admin_contact_message(contact_message)
    @contact_message = contact_message

    to = []
    to << 'Greg Leuch <contact@gleu.ch>'

    mail(to: to.join(', '), from: 'hello@gleu.ch', reply_to: contact_message.email, subject: "gleu.ch contact message (id: #{contact_message.uuid})")
  end

end
