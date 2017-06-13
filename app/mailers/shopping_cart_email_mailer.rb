class ShoppingCartEmailMailer < ApplicationMailer

  def shoppingdetails(hotel, event,user)
    @hotel = hotel
    @event = event
    @user = user
    mail to: => user.email, :subject => "Your cart details"
  end


end
