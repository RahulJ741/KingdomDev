class ForgetPassMailer < ApplicationMailer
  default from: 'rahul.j@infiny.in'

  def password_reset(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => "Password Reset"

  end
end
