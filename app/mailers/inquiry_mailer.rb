class InquiryMailer < ApplicationMailer
  default from: 'bethios@gmail.com'

  def new_inquiry(name, email, body)

    @name = name
    @email = email
    @body = body

    mail(to: 'bethios@gmail.com', subject: "New inquiry from #{name}")
  end
end
