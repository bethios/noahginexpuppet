class InquiryMailer < ApplicationMailer
  default to: 'bethios@gmail.com'

  def new_inquiry(name, email, body)
    @name = name
    @email = email
    @body = body

    mail(from: email, subject: "New inquiry from #{name}")
  end
end
