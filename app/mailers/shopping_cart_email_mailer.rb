class ShoppingCartEmailMailer < ApplicationMailer
  default from: 'info@kingdomsg.com'
  def shoppingdetails(hotel, event,user)
    @hotel = hotel
    @event = event
    @user = user
    mail :to => user.email, :subject => "Your cart details"
  end


end
