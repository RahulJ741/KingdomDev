class ShoppingCartController < ApplicationController
  def index
    # @cart = ShoppingCart.where(:user_id => session[:user_id])
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def add_cart
    @cart = ShoppingCart.create(:user_id => params[:user_id], :room_id => params[:room_id])
    @cart.save()
    redirect_to :back
  end

  def remove_from_cart
    @cart = ShoppingCart.where(:user_id => session[:user_id])
    @cart.find_by_room_id(params[:room_id]).destroy
    redirect_to :back
  end
end
