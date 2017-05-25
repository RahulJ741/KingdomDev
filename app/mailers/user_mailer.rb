class UserMailer < ApplicationMailer
  default from: 'rahul.j@infiny.in'

  def user_activation(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => "Account Confirmation"

  end
end
