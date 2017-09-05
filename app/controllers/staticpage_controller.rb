class StaticpageController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'digest/md5'
  # require "browser/aliases"
  # Browser::Base.include(Browser::Aliases)
  # browser = Browser.new("Some user agent")


  def add_image

    if request.post?
      puts "==============="
      HotelImage.where(hotel_id: params[:hotel_id]).destroy_all
      HotelImage.create(hotel_id: params[:hotel_id],pics: params[:pics])
    end
  end

  # def test_payment
  #
  #   url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/BookFunction")
  #   data = {"ContactComponentSubmission": {
  #               "Title": "Mr",
  #               "Position": "CTO",
  #               "FirstName": "John",
  #               "MiddleName": "Singleton",
  #               "Email": "xxx@jxxx.com",
  #               "Organization": "Centium Software",
  #               "AddressLineOne": "15 Miles Platting Road",
  #               "AddressLineTwo": "",
  #               "City": "Eight Mile Plains",
  #               "State": "QLD",
  #               "Postcode": "4213",
  #               "Country": "Australia"
  #
  #           },
  #               "Functions": [
  #               {
  #                 "UniqueFunctionCode": "AT0902A",
  #                 "FunctionPaycode": "No Charge",
  #                 "NoTickets": 155
  #               }
  #             ]
  #           }
  #   respose = kingdomsg_booking_api(url,data)
  #   puts "===================="
  #   puts respose
  # end

  def self.test_payment
    require 'paypal-sdk-rest'
    # @current_user = User.find(session["user_id"])
    @current_user = User.find(6)
    # Update client_id, client_secret and redirect_uri
    # PayPal::SDK.configure({
    #   :openid_client_id     => "client_id",
    #   :openid_client_secret => "client_secret",
    #   :openid_redirect_uri  => "http://localhost:3000/"
    # })
    # include PayPal::SDK::OpenIDConnect
    @payment = PayPal::SDK::REST::Payment.new({
          :intent => "sale",
          :payer => {
            :payment_method => "credit_card",
            :funding_instruments => [{
              :credit_card => {
                :type => "visa",
                :number => "4916550067336072",
                :expire_month => "11",
                :expire_year => "2019",
                :cvv2 => "874",
                :first_name => "Joe",
                :last_name => "Shopper",
                :billing_address => {
                    :line1 => @current_user.address,
                    :city => @current_user.city,
                    :state => @current_user.state,
                    :postal_code => @current_user.post_code,
                    :country_code => "AU" }
                }}]},
          :transactions => [{

            :amount => {
              :total => "1.00",
              :currency => "AUD" },
            :description => "This is the payment transaction description." }]})

        # Create Payment and return the status(true or false)
        @payment.create == false
        puts "==============="
        if @payment.create
          puts "done"
          puts @payment.inspect     # Payment Id
        else
          puts "not deone"
          puts @payment.error  # Error Hash
        end
    #   puts "}}}}}}}}}"
    # puts PayPal::SDK::REST::Payment.find("PAY-6ML74144SL1948036LE74JCA").inspect
        # redirect_to '/'
  end

  def index
      # @lists = Gibbon::API.lists
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    puts request.remote_ip
    # puts request.user_agent
    # puts response.inspect
    # puts browser.platform.name
    # puts browser.known?
    # puts browser.meta
    # puts browser.modern?
    puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    # puts session.inspect
    puts session[:user_id]

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]

    else
      @current_user = nil
    end
     @cart_count = Cart.where(:user_id => session[:user_id]).count

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
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def privacy
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def lookandbrand
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def whoweare
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def contact
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      # @current_user = nil
    end
  end

  def sports
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      # @current_user = nil
    end
  end

  def package
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
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
    for i in data['Functions'][0..50]
      data1 = {}
      n = i['Name'].index('/')-3
      data1['name'] = i['Name'][0..n]
      data1['date'] = i['Name'][n+1..n+5]
      data1["time"] = i['Name'][n+7..n+11]
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
      @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def createownpackage

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end



  def swimmingpackages
    @cart_count = Cart.where(:user_id => session[:user_id]).count
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
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def openingpackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages_gold
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count

      #  def check_user


    else
      @current_user = nil
    end

  end

  def rugbypackages_silver
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
       @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end

  end

  def rugbypackages_bronze
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = Cart.where(:user_id => session[:user_id]).count

      # @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def athleticspackages_platinum
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = Cart.where(:user_id => session[:user_id]).count

      # @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def athleticspackages_gold
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end


    url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetPackages")
    data = get_function(url)
    @event = []
    for i in data['Packages']
      data1 = {}
      data1['id'] = i['Id']
      data1['Amount'] = i['PackageAmount']
      data1['Code'] = i['UniquePackageCode'].first
      data1['Hotel'] = []
      data1['Event'] = []

      for b in i['HotelRooms']
        data2 = {}
        data2['Hotelname'] = b['HotelName']
        data2['Room_type'] = b['Name'].split('-').first
        data2['max_people'] = b['MaxOccupancy']
        data2['photo'] = b['Photos']
        data2['start_date'] = b['Range'].first['Date']
        data2['end_date'] = b['Range'].last['Date']
        data1['Hotel'].push(data2)
      end
      for e in i['Functions']
        data3 = {}
        data3['Name'] = e['FunctionGroupName']
        data3['Date'] = e['FunctionName'].split[-4]
        data3['start_time'] = e['FunctionName'].split[-3]
        data3['end_time'] = e['FunctionName'].split.last
        data3['category'] = e['Name']
        # data3['code_to_check'] = e['FunctionName'].split(" ").first
        # puts "+++++++++++++++++++++++++++++++++++++++++++++++"
        # puts data3['code_to_check']
        data3['cat_code'] = e['Code']
        data1['Event'].push(data3)
      end


      @event.push(data1)
    end

  end

  def athleticspackages_silver
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end

  end

  def athleticspackages_silver_brisbane
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end

  end

  def athleticspackages_bronze
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end

  end


  def subscribe
    # list_id = "8edfee3c52"

    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"], debug: true)
    puts "5555555555555564646466546"
    puts ENV["MAILCHIMP_LIST_ID"]
    puts params[:email]
    # gibbon.lists(list_id).members.create(body: {email_address: params[:email], status: "subscribed", merge_fields: {FNAME: "First Name", LNAME: "Last Name",MESSAGE: "done"}})
    tivd = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(body: {email_address: params[:email], status: "subscribed"})

    WelcomeEmailMailer.complete_subscription(params[:email]).deliver_now
    redirect_to root_path, :flash => {:success => "Subscription Complete"}
    # vids = Net::HTTP.get_response(tivd)
    # tivd = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members.retrieve
    # tivd = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members(9842F915B22D76D38AA32CD4B8C2DE05).retrieve
    puts "88888888888888888888888888888888888888888888888888888888888888888888"
    # flash[:notice] = "Subscription complete"
    # puts vids
    # if (response.status).to eq 400
    #     redirect_back(fallback_location: root_path)
    #     puts "hihihihiihihihii"
    # else
    #   redirect_back(fallback_location: root_path)
    #   puts "iiiiiiiiiiiiiiiiiiiiiiiiiii"
    # end

    puts "doooooooooooooooooooooooooooooooooo"

    # redirect_back(fallback_location: root_path)

  end


  def check_user
    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"], debug: true)
    begin
      puts "||||||||||||||||||||||||||\\\\\\\\\\\\\\\\\\"
      user_email = Digest::MD5.hexdigest(params[:email])
      puts params[:email]
      puts user_email
      check_user = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members(user_email).retrieve
      puts check_user
      # puts check_user.inspect


      puts "{{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{{}{}{}{}{}{}{}}}"

      render :json => false
    rescue Exception => e
      render :json => true
    end
  end



  def subscribed_user
    gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"], debug: true)
    email = params[:email]
    puts email
    user_email = email.gsub('$','.')
    puts "||||||||||||||||||"
    puts user_email
    user = Digest::MD5.hexdigest(user_email)
    subscribed_user = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members(user).update(body: {status: "subscribed"})
    redirect_to root_path, :flash => {:success => "Subscription Complete"}
  end


  def event_detail

  end


  def tour
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end
  end

  def self.book_function

    # url = URI("https://kingdomsg.eventsair.com/ksgapi/test-imports/ksgapi/ksgapi/BookFunction")
    #
    # http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #
    # request = Net::HTTP::Post.new(url)
    # request["apikey"] = 'wmQ87NZhMvWx5ZvrrStJPr9FG9WQ0wOSGVXxbUKDbjAuZC6k42M3x9GOzFt2umSQhRGylMwmBmlcU'
    # request["appusername"] = 'aaa@aaa.com'
    # request["apppassword"] = 'aaa@aaa.com'
    # request["content-type"] = 'application/json'
    # request["cache-control"] = 'no-cache'
    # # request["postman-token"] = '9799d4ab-7369-8113-027e-ae2ed424b049'
    # request.body = "{\n  \"ContactComponentSubmission\": {\n    \"Title\": \"Mr\",\n    \"Position\": \"CTO\",\n    \"FirstName\": \"John\",\n    \"MiddleName\": \"\",\n    \"LastName\": \"Singleton\",\n    \"Email\": \"xxx@jxxx.com\",\n    \"Organization\": \"Centium Software\",\n    \"AddressLineOne\": \"15 Miles Platting Road\",\n    \"AddressLineTwo\": \"\",\n    \"City\": \"Eight Mile Plains\",\n    \"State\": \"QLD\",\n    \"Postcode\": \"4213\",\n    \"Country\": \"Australia\"\n\n},\n    \"Functions\": [\n    {\n      \"UniqueFunctionCode\": \"IHO16C\",\n      \"FunctionPaycode\": \"No Charge\",\n      \"NoTickets\": 4\n    },\n    {\n      \"UniqueFunctionCode\": \"HO0703A\",\n      \"FunctionPaycode\": \"No Charge\",\n      \"NoTickets\": 6\n    }\n  ]\n}"
    #
    # response = http.request(request)
    # puts response.read_body
  end

  # comment out after demo

def thank_you
  if session[:user_id]
    @current_user = User.find(session["user_id"])
    puts session[:user_id]
    # @cart = ShoppingCart.where(:user_id => session[:user_id])
    @cart_count = Cart.where(:user_id => session[:user_id]).count

  else
    @current_user = nil
  end

end

 def plazzo

 end

 def synergy

 end

 def artique_resort

 end

 def ocean_pacific

 end

 def south_pacific_plaza

 end

 def chancellor_executive

 end

 def swiss_belhotel

 end

 def quest_spring_hill

 end

 def baronnet_apartment

 end

 def bay_apartments

 end

  def netball
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end
  end

  def openingpackagesinfo
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end
  end

  def swimmingpackagesinfo
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end
  end

  def netball_detail
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end
  end




  def get_packages

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end


    @category_name = params[:category]
    # if params[:event_name].include? '_'
    #   @event_name = params[:event_name].gsub! '_' , '+'
    # else
    #   @event_name = params[:event_name]
    # end
    @event_name = params[:event_name]

    event_pic = {
      'Athletics' => '/assets/images/games/KSGAthletics.jpg',
      'Rugby+Sevens' => '/assets/images/games/KSGRugby.jpg',
      'Opening+Ceremony' => '/assets/images/KSGOpeningCeremony.png',
      'Swimming' => '/assets/images/games/KSGSwimming.png',
      'Netball' => '/assets/images/games/KSGNetball.jpg'
    }

    if event_pic.key?@event_name
      @pic = event_pic[@event_name]
    else
      @pic = '/assets/images/games/KSGAthletics.jpg'
    end



    url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetPackages?eventGroup=#{@event_name}&group=#{@category_name}")
    puts "???????????????????????????????/////////////////////////////////////"
    puts url
    data = get_function(url)
    @event = []
    for i in data['Packages']
      data1 = {}
      data1['id'] = i['Id']
      data1['Amount'] = i['PackageAmount']
      data1['Code'] = i['UniquePackageCode'].first
      data1['Hotel'] = []
      data1['Event'] = []

      for b in i['HotelRooms']
        data2 = {}
        data2['Hotelname'] = b['HotelName']
        data2['description'] = b['Description']
        data2['Room_type'] = b['Name'].split('-').first
        data2['max_people'] = b['MaxOccupancy']
        data2['photo'] = b['Photos']
        data2['start_date'] = b['Range'].first['Date']
        data2['end_date'] = b['Range'].last['Date']
        data1['Hotel'].push(data2)
      end
      for e in i['Functions']
        data3 = {}
        data3['Name'] = e['FunctionGroupName']
        data3['Date'] = e['FunctionName'].split[-4]
        data3['start_time'] = e['FunctionName'].split[-3]
        data3['end_time'] = e['FunctionName'].split.last
        data3['category'] = e['Name']
        # data3['code_to_check'] = e['FunctionName'].split(" ").first
        # puts "+++++++++++++++++++++++++++++++++++++++++++++++"
        # puts data3['code_to_check']
        data3['cat_code'] = e['Code']
        data1['Event'].push(data3)
      end

      @event.push(data1)
    end

    @event = @event.sort_by {|x| x['Amount']}

  end



  def stats
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end

    staticpage_redirect = {
      "Opening+Ceremony/Silver" => 'staticpage/openingpackages.html.erb',
      "Swimming/silver" => 'staticpage/swimmingpackages.html.erb',
      "Netball/Silver" => 'staticpage/netball_detail.html.erb',
      "Rugby+Sevens/Gold" => 'staticpage/rugbypackages_gold.html.erb',
      "Rugby+Sevens/Silver" => 'staticpage/rugbypackages_silver.html.erb',
      "Rugby+Sevens/Silver-Brs" => 'layouts/404.html.erb',
      "Rugby+Sevens/Bronze" => 'staticpage/rugbypackages_bronze.html.erb',
      "Athletics/Platinum" => 'staticpage/athleticspackages_platinum.html.erb',
      "Athletics/Gold" => 'layouts/404.html.erb',
      "Athletics/Silver" => 'staticpage/athleticspackages_silver.html.erb',
      "Athletics/Silver-Brs" => 'staticpage/athleticspackages_silver_brisbane.html.erb',
      "Athletics/Bronze" => 'staticpage/athleticspackages_bronze.html.erb'
    }

    # render 'staticpage/athleticspackages_silver_brisbane.html.erb'
    @keys_s = (params[:event]+"/"+params[:category]).to_s
    # puts ":::::::::::::::::::::::::::@keys_s"
    # puts @keys_s
    if staticpage_redirect.key?@keys_s
      # puts "true"
      # puts staticpage_redirect[@keys_s]
      # @hit = "staticpage"+"/"+(staticpage_redirect[@keys_s])
      # puts @hit
      render staticpage_redirect[@keys_s]
    else
      render 'layouts/404.html.erb'
    end
  end



  def hotel_info_redirect
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      # @cart = ShoppingCart.where(:user_id => session[:user_id])
      @cart_count = Cart.where(:user_id => session[:user_id]).count

    else
      @current_user = nil
    end

    hotel_info = {
      'Ocean Pacific Resort' => '/hotel/ocean_pacific',
      'The Bay Apartments' => '/hotel/bay_apartments',
      'Baronnet Apartments' => '/hotel/baronnet_apartment',
      'Swiss-Belhotel Brisbane' => '/hotel/swiss_belhotel',
      'South Pacific Plaza' => '/hotel/south_pacific_plaza',
      'The Chancellor Lakeside' => '/hotel/chancellor_executive',
      'The Chancellor Executive'=> '/hotel/chancellor_executive',
      'Quest Spring Hill' => '/hotel/quest_spring_hill',
      'Ocean Pacific Resort' => '/hotel/ocean_pacific',
      'Synergy Broadbeach' => '/hotel/synergy',
      'Palazzo Versace' => '/hotel/plazzo'
    }

    # puts "}}}}}}}}}}}}}}}}}}}}}}}]"
    # puts params[:hotel_name]
    if hotel_info.key?params[:hotel_name]
      # puts 'true'
      @raoute = params[:hotel_name]
      # puts @raoute
      # puts hotel_info[@raoute]
      redirect_to hotel_info[@raoute]
    else
      render 'layouts/404.html.erb'
    end

  end




end
