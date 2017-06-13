class ShoppingCartController < ApplicationController
  def index
    # @cart = ShoppingCart.where(:user_id => session[:user_id])
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @hotels = HotelShoppingCart.where(:user_id => session[:user_id])
      @events = EventShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def add_cart
    @cart = ShoppingCart.create(:user_id => params[:user_id], :room_id => params[:room_id])
    @cart.save()
    puts "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
    puts @cart.errors.full_messages
    redirect_to :back, :flash => {:success => 'Added to cart'}
  end

  def remove_from_cart
    @cart = ShoppingCart.where(:user_id => session[:user_id])
    @cart.find_by_room_id(params[:room_id]).destroy
    redirect_to :back, :flash => {:error => 'Removed from cart'}
  end

  def remove_from_cart_event
    @cart = EventShoppingCart.find(params[:id]).destroy
    
    redirect_to :back, :flash => {:error => 'Event removed from cart'}
  end

  def event_add_cart
    edate = (params[:event_date]+'/2018').to_s

    @cart = EventShoppingCart.create(:user_id => params[:user_id], :event_id => params[:event_id], :event_name => params[:event_name], :event_date =>  Date.strptime(edate,"%d/%m/%Y"), :event_cat => params[:event_cat], :rate => params[:event_rate])
    @cart.save
  
    puts @cart.errors.full_messages
    redirect_to :back, :flash => {:success => 'Added to cart'}
  end

end
