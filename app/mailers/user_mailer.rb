class UserMailer < ApplicationMailer

  def thank_you(user)

    mail to: user.email, subject: "Welcome to The Machine!"
  end
end
