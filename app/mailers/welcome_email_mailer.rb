class WelcomeEmailMailer < ApplicationMailer
  default from: 'rahul.j@infiny.in'

  def welcomeemail(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => "Welcome to kingdomsg2018"

  end

  def shoppingdetails(hotel, event,user)
    @hotel = hotel
    @event = event
    @user = user
    mail :to => user.email, :subject => "Your cart details"
  end

  def rate_exteted(user)
    @user = user
    mail :to => user.email, :subject => "Your payment exteded"

    # mail to: => "", :subject => "Payment exteded of user"
  end

end
