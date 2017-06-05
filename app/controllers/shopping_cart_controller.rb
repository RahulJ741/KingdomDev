class ShoppingCartController < ApplicationController
  def index
    @cart = ShoppingCart.where(:user_id => session[:user_id])
  end

  def add_cart
    @cart = ShoppingCart.create(:user_id => params[:user_id], :room_id => params[:room_id])
    @cart.save()
    redirect_to :back
  end
end
