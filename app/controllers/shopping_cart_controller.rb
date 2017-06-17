class ShoppingCartController < ApplicationController
  def index
    @cart_count = Cart.where(:user_id => session[:user_id]).count
    @msg = "Note: All orders above $2500 will be checked by the site admins and the customer will be contacted offline"
    if session[:user_id]
      @current_user = User.find(session["user_id"])

      puts session[:user_id]
      cart = Cart.where(:user_id => session[:user_id])
      puts cart.inspect
      @cart_data = []
      for i in cart
        data1 = {}
        if i.item == 'event'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
          data = kingdomsg_api(url)
          catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

          event = Event.find(i.item_id)
          data1['item_type'] = 'Event'
          data1['name'] = event.name+", "+catagory['Name']
          data1['available'] = catagory['Available']
          data1['amount'] = catagory['Amount']
          data1['quantity'] = i.quantity
          data1['event_date'] = event.date.strftime("%d %b %y")
        end
        @cart_data.push(data1)
      end
    else
      @current_user = nil
    end
  end

  # def add_cart
  #   @cart = HotelShoppingCart.create(:user_id => params[:user_id],:room_type => params[:room_type],rate: params[:rate],hotel_id: params[:hotel_id],room_unique_id: params[:room_unique_id])
  #   @cart.save()
  #   puts "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
  #   puts @cart.errors.full_messages
  #   redirect_to :back, :flash => {:success => 'Added to cart'}
  # end

  def remove_from_cart_hotel
    @cart = HotelShoppingCart.find(params[:id]).destroy

    redirect_to :back, :flash => {:error => 'Room removed from cart'}
  end

  def remove_from_cart_event
    @cart = EventShoppingCart.find(params[:id]).destroy

    redirect_to :back, :flash => {:error => 'Event removed from cart'}
  end

  def event_add_cart
    Cart.create(:user_id => session[:user_id],:item => 0,:item_id => params[:item_id],:item_uid => params[:item_uid],:item_cat_code => params[:item_cat_code],:quantity => ((params[:quantity]).to_i).abs )
    redirect_to :back, :flash => {:success => 'Added to cart'}
  end

  def checkout

    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = Cart.where(:user_id => session[:user_id]).count

      # getting total with api call
      puts "hihihihiihihihii"
      cart = Cart.where(:user_id => session[:user_id])
      puts cart.inspect

      @cart_data = []
      for i in cart
        data1 = {}
        if i.item == 'event'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
          data = kingdomsg_api(url)
          catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

          event = Event.find(i.item_id)
          data1['item_type'] = 'Event'
          data1['name'] = event.name+", "+catagory['Name']
          data1['available'] = catagory['Available']
          data1['amount'] = catagory['Amount']
          data1['quantity'] = i.quantity
          data1['event_date'] = event.date.strftime("%d %b %y")
        end
        @cart_data.push(data1)
      end
        total = @cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
        puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\\\\\\\\\\\\\\\\\\\\\"
        puts total
        # remove this code latter just to gete the cart functionality running



      # total = ((HotelShoppingCart.where(user_id: session[:user_id]).sum('rate') + EventShoppingCart.where(user_id: session[:user_id]).sum('rate')).round(2))
      # redirect_to :back,:flash => {:msg => @msg}
      if total > 2500
        puts "--------------------"
        WelcomeEmailMailer.rate_exteted(@current_user).deliver_now
        # @msg = "Note: All orders above $2500 will be checked by the site admins and the customer will be contacted offline"
        # redirect_to :back, :flash => {:msg => @msg}

      end
    else
      @current_user = nil
    end
  end

  def make_payment
    # delete this Code
    cart = Cart.where(:user_id => session[:user_id])
    puts cart.inspect

    @cart_data = []
    for i in cart
      data1 = {}
      if i.item == 'event'
        url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
        data = kingdomsg_api(url)
        catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

        event = Event.find(i.item_id)
        data1['item_type'] = 'Event'
        data1['name'] = event.name+", "+catagory['Name']
        data1['available'] = catagory['Available']
        data1['amount'] = catagory['Amount']
        data1['quantity'] = i.quantity
        data1['event_date'] = event.date.strftime("%d %b %y")
      end
      @cart_data.push(data1)
    end
      total = @cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
      puts "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\\\\\\\\\\\\\\\\\\\\\"
      puts total
      # delete this Code
    # total = ((HotelShoppingCart.where(user_id: session[:user_id]).sum('rate') + EventShoppingCart.where(user_id: session[:user_id]).sum('rate')).round(2))
    puts params[:cardNumber].delete(' ')
    total = sprintf("%.2f",total)
    puts "=================="
    require 'paypal-sdk-rest'
    user = User.find(session[:user_id])
    # @hotels = HotelShoppingCart.where(:user_id => session[:user_id])
    # @events = EventShoppingCart.where(:user_id => session[:user_id])

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
          puts @payment.id # Payment Id

          puts "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
          # my paymment update after making a payment
          @del_cart = Cart.where(user_id: session[:user_id])
          @del_cart.each do |mo|
            MyOrder.create(user_id: session[:user_id], item: mo.item, item_id: mo.item_id, item_uid: mo.item_uid, item_cat_code: mo.item_cat_code, quantity: mo.quantity, payment_id: @payment.id)
          end
          # WelcomeEmailMailer.shoppingdetails(@hotels, @events,user).deliver_now

            MyPayment.create(user_id: session[:user_id], payment_id: @payment.id, total: total, date: Time.current.to_date)


            @del_cart.destroy_all

          # end
          # for i in HotelShoppingCart.where(user_id: user.id)
          #     HotelTransaction.create(:user_id => i.user_id,:room_type => i.room_type,rate: i.rate,hotel_id: i.hotel_id,room_unique_id: i.room_unique_id,from_date: i.from_date,to_date: i.to_date,status: 'completed',pay_id: @payment.id)
          # end
          #
          # for i in EventShoppingCart.where(user_id: user.id)
          #     EventTransaction.create(:user_id => i.user_id, :event_id => i.event_id, :event_name => i.event_name, :event_date =>  i.event_date, :event_cat => i.event_cat, :rate => i.rate,status: 'completed',pay_id: @payment.id)
          # end
          #
          # HotelShoppingCart.where(user_id: user.id).destroy_all
          # EventShoppingCart.where(user_id: user.id).destroy_all
          redirect_to '/', :flash => {:success => 'Payment Successfull'}

        else
          puts "not deone"
          puts @payment.error  # Error Hash
          redirect_to :back, :flash => {:error => 'Somthing went wrong'}
        end
  end

  def my_transaction
    @cart_count = Cart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      my_order = MyOrder.where(user_id: session[:user_id])
      #delete from here
      @my_order = []
      for i in my_order
        data1 = {}
        if i.item == 'event'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
          data = kingdomsg_api(url)
          catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

          event = Event.find(i.item_id)
          data1['item_type'] = 'Event'
          data1['name'] = event.name+", "+catagory['Name']
          data1['available'] = catagory['Available']
          data1['amount'] = catagory['Amount']
          data1['quantity'] = i.quantity
          data1['event_date'] = event.date.strftime("%d %b %y")
        end
        @my_order.push(data1)
      end
        @total = @my_order.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
      # @hotels = HotelTransaction.where(:user_id => session[:user_id])
      # @events = EventTransaction.where(:user_id => session[:user_id])
    else
      @current_user = nil
    end
  end

end
