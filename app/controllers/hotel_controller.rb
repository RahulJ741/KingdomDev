class HotelController < ApplicationController

  require 'uri'
  require 'net/http'

  def info

    @hotel = Hotel.find(params[:id])
    @rooms = @hotel.rooms
    @room_type = Room.where(:hotel_id => params[:id]).distinct.pluck(:rooms_type)

    # @room_size = Room.where(:hotel_id => params[:id]).distinct.pluck(:size)
    # @max_occupancy = Room.where(:hotel_id => params[:id]).distinct.pluck(:max_occupancy)
    # @room_ids = Room.where(:hotel_id => params[:id]).pluck(:id)
    # @rf_ids =  RoomsFeature.where(room_id: @room_ids)
    @features = Feature.all
    # Room.where(:hotel_id => params[:id]).distinct.pluck(:features)

    puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    puts @hotel.unique_id
    url = URI("https://kingdomsg.eventsair.com/ksgapi/test-imports/ksgapi/ksgapi/GetHotelInfo?hotelid=#{@hotel.unique_id}")
    puts url
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request2 = Net::HTTP::Get.new(url)
    request2["apikey"] = 'wmQ87NZhMvWx5ZvrrStJPr9FG9WQ0wOSGVXxbUKDbjAuZC6k42M3x9GOzFt2umSQhRGylMwmBmlcU'
    request2["appusername"] = 'aaa@aaa.com'
    request2["apppassword"] = 'aaa@aaa.com'
    request2["content-type"] = 'application/json'
    request2["cache-control"] = 'no-cache'
    # request2["postman-token"] = '91a73d67-63ec-a9b0-819d-39b4ce08f3b9'

    response = http.request(request2)
    puts "<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<>>>>>>>>>>>>"
    puts response.read_body
    puts "{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"
    data = JSON.parse(response.body)
    @rooms_data = data['HotelInfo']['Rooms'].pluck('Id', 'Name','Description', 'Range')
    puts @rooms_data
    puts @rooms_data.length
    puts "{{}{}{}{}{}{}{}{}{}{}{}{}{}{{{}}}}"
    puts @rooms_data.first.second.split.first
    puts ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'

    # for i in 0..@rooms_data.length
    #   if Room.find
    #     continue
    #   else
    #     Room.create(unique_id:@rooms_data.first ,name:@rooms_data.second, max_occupancy:@rooms_data.third,hotel_id:@hotel.id)
    #   end
    # end

    if request.post?
      @rooms_data = @rooms_data.select{|d| d[1] == params[:rooms_type]}
      # @roomsf = Room.rooms_type()
      # @rooms = @hotel.rooms.rooms_type(params[:rooms_type]).room_size(params[:room_size]).max_occupancy(params[:max_occupancy]).hotel_id(params[:hotel_id])
    end

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end



  end







  def accommodation


    # url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetHotels")
    #
    # http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #
    # request1 = Net::HTTP::Get.new(url)
    # request1["apikey"] = 'wmQ87NZhMvWx5ZvrrStJPr9FG9WQ0wOSGVXxbUKDbjAuZC6k42M3x9GOzFt2umSQhRGylMwmBmlcU'
    # request1["appusername"] = 'aaa@aaa.com'
    # request1["apppassword"] = 'aaa@aaa.com'
    # request1["content-type"] = 'application/json'
    # request1["cache-control"] = 'no-cache'
    #
    #
    # response = http.request(request1)
    # # puts response.read_body
    # data = JSON.parse(response.body)
    # @hotels = data['Hotels'].pluck('Id','Name','Stars')
    # # @hotels[11][2]=2
    # puts @hotels.inspect
    # if request.post?
    #   @hotels = @hotels.select{ |h| h[2].to_i== params[:star_rating].to_i }
    #   # @hotels = Hotel.star_rating(params[:star_rating]) if params[:star_rating].present?
    #   @opt_val = params[:star_rating]
    # end
    #
    #  @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    # if session[:user_id]
    #   @current_user = User.find(session["user_id"])
    #   puts session[:user_id]
    # else
    #   @current_user = nil
    # end

  end

end
