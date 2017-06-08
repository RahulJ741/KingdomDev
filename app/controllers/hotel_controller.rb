class HotelController < ApplicationController
  # require 'faraday'
  # require 'faraday_middleware'
  require 'uri'
  require 'net/http'

  def info

    @hotel = Hotel.find(params[:id])
    @rooms = @hotel.rooms
    @room_type = Room.where(:hotel_id => params[:id]).distinct.pluck(:rooms_type)
    # puts "pppppppppppppppppppp"
    # puts params[:id]
    # puts @room_type
    @room_size = Room.where(:hotel_id => params[:id]).distinct.pluck(:size)
    @max_occupancy = Room.where(:hotel_id => params[:id]).distinct.pluck(:max_occupancy)
    # @room_ids = Room.where(:hotel_id => params[:id]).pluck(:id)
    # @rf_ids =  RoomsFeature.where(room_id: @room_ids)
    @features = Feature.all
    # Room.where(:hotel_id => params[:id]).distinct.pluck(:features)

    url = URI("https://kingdomsg.eventsair.com/ksgapi/test-imports/ksgapi/ksgapi/GetHotels")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request1 = Net::HTTP::Get.new(url)
    request1["apikey"] = 'wmQ87NZhMvWx5ZvrrStJPr9FG9WQ0wOSGVXxbUKDbjAuZC6k42M3x9GOzFt2umSQhRGylMwmBmlcU'
    request1["appusername"] = 'aaa@aaa.com'
    request1["apppassword"] = 'aaa@aaa.com'
    request1["content-type"] = 'application/json'
    request1["cache-control"] = 'no-cache'
    request1["postman-token"] = '91a73d67-63ec-a9b0-819d-39b4ce08f3b9'

    response = http.request(request1)
    # puts response.read_body
    data = JSON.parse(response.body)
    gitt = data.first
    gitt.second.pluck('Name')
    puts gitt.second.pluck('Name')#data['Hotels']['Id']

    # response.(only: [:Id])
    # puts response.read_body(only: [:Id])
    puts "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]"




    # events.each do |event_hash|
    #    event_hash.keep_if { |key, _| [:event_name, :cruise_ship_name].include?(key) }
    # end
    #
    # puts events


    if request.post?
      # room = Room.find(params[:])
      @roomsf = Room.rooms_type()
      # @rooms = @hotel.rooms.rooms_type(params[:rooms_type]).room_size(params[:room_size]).max_occupancy(params[:max_occupancy]).hotel_id(params[:hotel_id])
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
