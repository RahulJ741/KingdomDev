class HotelController < ApplicationController

  def info
    @hotel = Hotel.find(params[:id])
    @rooms = @hotel.rooms
    @room_type = Room.distinct.pluck(:rooms_type)
    @room_size = Room.distinct.pluck(:size)
    @max_occupancy = Room.distinct.pluck(:max_occupancy)

    if request.post?
      @rooms = @hotel.rooms.rooms_type(params[:rooms_type]).room_size(params[:room_size]).max_occupancy(params[:max_occupancy]).hotel_id(params[:hotel_id])
    end

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

end
