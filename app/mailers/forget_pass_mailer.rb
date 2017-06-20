class ForgetPassMailer < ApplicationMailer
  default from: 'info@kingdomsg.com'

  def password_reset(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => "Password Reset"

  end
end
