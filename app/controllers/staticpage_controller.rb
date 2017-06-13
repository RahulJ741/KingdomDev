class StaticpageController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
      # @lists = Gibbon::API.lists
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    # puts session.inspect
    puts session[:user_id]

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
    else
      @current_user = nil
    end
     @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count

    # @current_user = User.find(session[:user_id])

    # @county = Country.where(is_active: true).all
    @exclusive = Exclusive.where(is_active: true).all
    @exclusive_second = ExclusiveSecond.where(is_active: true).order('order_by asc')

    @bhead = 'Gold Coast <span> 2018 </span> Commonwealth games'
    @bstext = 'Travel Packages and Event Tickets are now available for the Gold Coast 2018 Commonwealth Games. <strong> Kingdom Sports Group is an Exclusive Authorised Ticket Reseller </strong> for 28 countries as well as an Authorised Ticket Reseller for Malta and Cyprus and all EU / EEA countries.'
  end

  def city
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def privacy
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def lookandbrand
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def whoweare
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def contact
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      # @current_user = nil
    end
  end

  def sports
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      # @current_user = nil
    end
  end

  def package
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      # @current_user = nil
    end

  end

  def event
    url = URI("https://kingdomsg.eventsair.com/ksgapi/test-imports/ksgapi/ksgapi/GetFunctions")

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
    # @hotels = data['Hotels'].pluck('Id','Name','Stars')
    puts "==========="
    @events = []
    for i in data['Functions'][0..10]
      data1 = {}
      n = i['Name'].index('/')-3
      data1['name'] = i['Name'][0..n]
      data1['date'] = i['Name'][n+1..n+5]
      data1['event_id'] = i['Id']
      data1['cat'] =[]
      for j in i['FeeTypes']
        data2 ={}
        data2['name'] = j['Name']
        data2['rate'] = j['Amount']
        data1['cat'].push(data2)
      end
      @events.push(data1)
    end

    @all_events = @events.map { |h| h['name'] }.uniq

    if not params[:event].blank?
      @events = @events.select {|a| a["name"] == params[:event] }
    end

    if not params[:start_date].blank?
      @events = @events.select {|a| a["date"] == params[:start_date][0..4] }
    end

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def createownpackage

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end



  def swimmingpackages
    @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
    else
      @current_user = nil
    end

  end

  def athleticspackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def openingpackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages_gold
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages_silver
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages_bronze
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def athleticspackages_platinum
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def athleticspackages_gold
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def athleticspackages_silver
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def athleticspackages_silver_brisbane
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def athleticspackages_bronze
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end


  def subscribe
    # list_id = "8edfee3c52"

    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"], debug: true)
    puts "5555555555555564646466546"
    puts ENV["MAILCHIMP_LIST_ID"]
    # gibbon.lists(list_id).members.create(body: {email_address: params[:email], status: "subscribed", merge_fields: {FNAME: "First Name", LNAME: "Last Name",MESSAGE: "done"}})
    tivd = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(body: {email_address: params[:email], status: "PENDING"})
    # vids = Net::HTTP.get_response(tivd)
    puts "88888888888888888888888888888888888888888888888888888888888888888888"
    flash[:notice] = "Subscription complete"
    # puts vids
    # if (response.status).to eq 400
    #     redirect_back(fallback_location: root_path)
    #     puts "hihihihiihihihii"
    # else
    #   redirect_back(fallback_location: root_path)
    #   puts "iiiiiiiiiiiiiiiiiiiiiiiiiii"
    # end

    puts "doooooooooooooooooooooooooooooooooo"

    redirect_back(fallback_location: root_path)

  end



end
