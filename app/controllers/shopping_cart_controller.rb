class ShoppingCartController < ApplicationController

  def helpers
    ActionController::Base.helpers
  end

  def index
    @cart_count = Cart.where(:user_id => session[:user_id]).count
   
    if session[:user_id]
      @current_user = User.find(session["user_id"])

      puts session[:user_id]
      cart = Cart.where(:user_id => session[:user_id])
      puts cart.inspect
      @is_exceed = false
      @cart_data = []
      for i in cart
        data1 = {}
        if i.item == 'event'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
          data = kingdomsg_api(url)
          catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

          event = Event.find(i.item_id)
          data1['cart_id'] = i.id
          data1['item_type'] = 'Event'
          data1['name'] = event.name+", "+catagory['Name']
          data1['available'] = catagory['Available']
          data1['amount'] =  catagory['Amount'].to_f % 1 == 0 ? catagory['Amount'].to_i : helpers.number_with_precision(catagory['Amount'].to_f, :precision => 2)
          data1['quantity'] = i.quantity
          data1['event_date'] = event.date.strftime("%d %b %y")
          if i.quantity.to_i > catagory['Available'].to_i
            data1['is_exceed'] = true
            @is_exceed = true
          else
            data1['is_exceed'] = false
          end
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

  def remove
    @cart = Cart.find(params[:id]).destroy

    redirect_to :back, :flash => {:success => 'Item removed from cart'}
  end

  def update
    cart = Cart.find(params[:item_id])
    cart.quantity = params[:quantity]
    cart.save
    render :json => true
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
      if total.to_f >= 2500
        puts "--------------------"

        @del_cart = Cart.where(user_id: session[:user_id])
        if MyPayment.where('order_id Is NOT NULL').last.blank?
          order_id = 1
        else
          order_id = (MyPayment.all.last.order_id)+1
        end
        pymt = MyPayment.create(user_id: session[:user_id], order_id: order_id, total: total, date: Time.current.to_date)
        @del_cart.each do |mo|
          
          MyOrder.create(user_id: session[:user_id], item: mo.item, item_id: mo.item_id, item_uid: mo.item_uid, item_cat_code: mo.item_cat_code, quantity: mo.quantity, my_payment_id: pymt.id)
        end

        @del_cart.destroy_all
        WelcomeEmailMailer.rate_exteted(@current_user).deliver_now
       redirect_to :back, :flash => {:success => 'Your Is Transaction Under Review'}

      end
    else
      @current_user = nil
    end
  end

  def review_order
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      @cart_count = Cart.where(:user_id => session[:user_id]).count
      
    else
      @current_user = nil
    end
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
    @total = @cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
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
          
          # WelcomeEmailMailer.shoppingdetails(@hotels, @events,user).deliver_now

          pymt = MyPayment.create(user_id: session[:user_id], payment_id: @payment.id, total: total, date: Time.current.to_date)
          @del_cart.each do |mo|
            MyOrder.create(user_id: session[:user_id], item: mo.item, item_id: mo.item_id, item_uid: mo.item_uid, item_cat_code: mo.item_cat_code, quantity: mo.quantity, my_payment_id: pymt.id)
          end

            @del_cart.destroy_all

          redirect_to '/thank_you', :flash => {:success => 'Payment Successfull'}

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

      my_order1 = MyPayment.where("user_id = ? AND payment_id IS NOT NULL",session[:user_id])

      @my_order = []
      for p in my_order1
        for i in p.my_orders
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
      end
      p_order = MyPayment.where("user_id = ? AND order_id IS NOT NULL",session[:user_id])

      @pending_order = []
      for o in p_order
        for i in o.my_orders
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
          @pending_order.push(data1)
        end
      end
    else
      @current_user = nil
    end
  end

end
