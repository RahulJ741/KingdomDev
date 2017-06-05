class HotelController < ApplicationController

  def info
    @hotel = Hotel.find(params[:id])
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

end
