class WelcomeEmailMailer < ApplicationMailer
  default from: 'info@kingdomsg.com'

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

  def complete_subscription(email)
    ig_email =  email
    @t_email = email
    @t_email = @t_email.gsub('.','$')
    puts "======================="

    puts ig_email
    mail :to => ig_email, :subject => "Complete Subscription"
  end

end
