class AdminController < ApplicationController
  def index
    @users = User.all
    # @rooms = Room.all
    # @hotel = Hotel.all
    # @feature = Feature.all
    # @room_feature = RoomsFeature.all
  end

  def rooms
    @rooms = Room.all
  end

  def hotels
    @hotel = Hotel.all
  end

  def features
    @feature = Feature.all
  end

  def room_feature
    @room_feature = RoomsFeature.all
  end

end
