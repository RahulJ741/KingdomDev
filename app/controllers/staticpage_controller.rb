class StaticpageController < ApplicationController

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
    @cart = ShoppingCart.where(:user_id => session[:user_id])

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
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def privacy
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def lookandbrand
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def whoweare
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def contact
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      # @current_user = nil
    end
  end

  def sports
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      # @current_user = nil
    end
  end

  def package
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      # @current_user = nil
    end

  end

  def event
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def createownpackage

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def accommodation
    @hotels = Hotel.all

    if request.post?
      @hotels = Hotel.star_rating(params[:star_rating]) if params[:star_rating].present?
      @opt_val = params[:star_rating]
    end

    @cart = ShoppingCart.where(:user_id => session[:user_id])
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
    else
      @current_user = nil
    end

  end

  def swimmingpackages
    @cart = ShoppingCart.where(:user_id => session[:user_id])
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
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def rugbypackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def openingpackages
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def rugbypackages_gold
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end

  end

  def rugbypackages_silver
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart = ShoppingCart.where(:user_id => session[:user_id])
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
    tivd = gibbon.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(body: {email_address: params[:email], status: "subscribed"})
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
