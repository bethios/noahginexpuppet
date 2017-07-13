class InquiryMailer < ApplicationMailer
  default from: 'colonelernie@gmail.com'

  def new_inquiry(email, name, body)
    @email = email
    @name = name
    @body = body

    mail(to: 'colonelernie@gmail.com', subject: "New inquiry from #{@name}")
  end
end
