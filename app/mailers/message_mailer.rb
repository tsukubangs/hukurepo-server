class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.hello.subject
  #
  def new_response(user)
    @user = user
    @greeting = "Hi"
    mail to: @user.email, subject: "You got a response"
  end
end
