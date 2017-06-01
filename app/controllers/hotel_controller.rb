class HotelController < ApplicationController

  def info
    @hotel = Hotel.find(params[:id])
  end

end
