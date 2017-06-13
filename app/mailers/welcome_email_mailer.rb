class WelcomeEmailMailer < ApplicationMailer
  default from: 'rahul.j@infiny.in'

  def welcomeemail(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => "Welcome to kingdomsg2018"

  end
end
