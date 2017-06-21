class UserMailer < ApplicationMailer
  default from: 'info@kingdomsg.com'

  def user_activation(user)
    @greeting = "Hi"
    @user = user
    puts "454545455454545445454545454545"

    mail :to => user.email, :subject => " Account Activation – Kingdom Sports Group"

  end
end
