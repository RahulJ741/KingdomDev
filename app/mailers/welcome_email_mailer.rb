class WelcomeEmailMailer < ApplicationMailer
  default from: 'info@kingdomsg.com'

  def welcomeemail(user)
    @greeting = "Hi"
    @user = user
    mail :to => user.email, :subject => "Welcome to kingdomsg2018"

  end

  def shoppingdetails(cart ,user)
    @cart  = cart
    @user = user
    admin_shopping_cart(@cart, @user)
    mail :to => user.email, :subject => "Your cart details"
  end

  def rate_exteted(cart, user)
    @cart_data = cart
    @user = user
    admin_rate_exteted(@cart_data ,@user)
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

  def admin_rate_exteted(cart,user)
    @cart = cart
    @user = user
    mail :to => "info@kingdomsg.com", :subject => "User shopping cart rate exceded"
  end

  def admin_shopping_cart(cart, user)
    @cart_data = cart
    @user = user
    mail :to => "info@kingdomsg.com", :subject => "User shopping cart details"
  end

  def subscribed_welcome_user(email)
    @email_subscribed = email
    mail :to => @email_subscribed, :subject => "Thank you for subscription"
  end

end
