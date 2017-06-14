class ShoppingCartController < ApplicationController
  def index
    @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
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
    @cart = HotelShoppingCart.create(:user_id => params[:user_id],:room_type => params[:room_type],rate: params[:rate],hotel_id: params[:hotel_id],room_unique_id: params[:room_unique_id])
    @cart.save()
    puts "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
    puts @cart.errors.full_messages
    redirect_to :back, :flash => {:success => 'Added to cart'}
  end

  def remove_from_cart_hotel
    @cart = HotelShoppingCart.find(params[:id]).destroy

    redirect_to :back, :flash => {:error => 'Room removed from cart'}
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

  def checkout

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
      total = ((HotelShoppingCart.where(user_id: session[:user_id]).sum('rate') + EventShoppingCart.where(user_id: session[:user_id]).sum('rate')).round(2))
      if total > 2500
        puts "--------------------"
        @msg = "Since your billing amount exceeds 2500$ we have informed admin they will contact you regarding your order"
        redirect_to :back, :flash => {:msg => @msg}
      end
    else
      @current_user = nil
    end
  end

  def make_payment
    total = ((HotelShoppingCart.where(user_id: session[:user_id]).sum('rate') + EventShoppingCart.where(user_id: session[:user_id]).sum('rate')).round(2))
    puts params[:cardNumber].delete(' ')
    total = sprintf("%.2f",total)
    puts "=================="
    require 'paypal-sdk-rest'
    user = User.find(session[:user_id])
    @hotels = HotelShoppingCart.where(:user_id => session[:user_id])
    @events = EventShoppingCart.where(:user_id => session[:user_id])
    
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
                :number => params[:cardNumber].delete(' '),
                :expire_month => params[:cardExpiry].split('/')[0].delete(' '),
                :expire_year => params[:cardExpiry].split('/')[1].delete(' '),
                :cvv2 => params[:cardCVC].delete(' '),
                :first_name => user.first_name,
                :last_name => user.last_name,
                :billing_address => {
                  :line1 => "52 N Main ST",
                  :city => "Johnstown",
                  :state => "OH",
                  :postal_code => "43210",
                  :country_code => "US" }}}]},
          :transactions => [{

            :amount => {
              :total => total,
              :currency => "USD" },
            :description => "This is the payment transaction description." }]})

        # Create Payment and return the status(true or false)
        puts "==============="
        if @payment.create
          puts "done"
          puts @payment.inspect # Payment Id
          WelcomeEmailMailer.shoppingdetails(@hotels, @events,user).deliver_now
          for i in HotelShoppingCart.where(user_id: user.id)
              HotelTransaction.create(:user_id => i.user_id,:room_type => i.room_type,rate: i.rate,hotel_id: i.hotel_id,room_unique_id: i.room_unique_id,from_date: i.from_date,to_date: i.to_date,status: 'completed')
          end  

          for i in EventShoppingCart.where(user_id: user.id)
              EventTransaction.create(:user_id => i.user_id, :event_id => i.event_id, :event_name => i.event_name, :event_date =>  i.event_date, :event_cat => i.event_cat, :rate => i.rate,status: 'completed')
          end     
          
          HotelShoppingCart.where(user_id: user.id).destroy_all
          EventShoppingCart.where(user_id: user.id).destroy_all
          redirect_to '/', :flash => {:success => 'Payment Successfull'}

        else
          puts "not deone"
          puts @payment.error  # Error Hash
          redirect_to :back, :flash => {:error => 'Somthing went wrong'}
        end
  end

  def my_transaction
    @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @hotels = HotelTransaction.where(:user_id => session[:user_id])
      @events = EventTransaction.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

end
