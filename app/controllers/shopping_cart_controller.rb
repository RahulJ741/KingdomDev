class ShoppingCartController < ApplicationController

  def helpers
    ActionController::Base.helpers
  end

  def index
    @cart_count = Cart.where(:user_id => session[:user_id]).count
    # @carttr = Cart.where(:user_id => session[:user_id])
    # @carttr.each do |hit|
    #   @o = ErrorCart.create(hit.attributes)
    #   @o.error_message = "hihihihiihihihii"
    #   @o.save
    # end

    if MyPayment.where(user_id: session[:user_id]).all.blank?
      @is_new =true
    else
      @is_new =false
    end
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
          data1['start_time'] = event.start_time.strftime("%I:%M %p")
          data1['end_date'] = event.end_time.strftime("%I:%M %p")
          data1['code'] = catagory['Code']
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
    puts "====asa"

    @cart = Cart.find_by_item_cat_code_and_user_id(params[:item_cat_code],session[:user_id])
    if @cart.present?
      redirect_to :back, :flash => {:error => 'Event already added to cart'}
    else
      if params[:item_id].blank? or params[:item_uid].blank? or params[:item_cat_code].blank? or params[:quantity].blank?
        redirect_to session[:url], :flash => {:error => 'Item not added to cart.Please try again'}
      else
        Cart.create(:user_id => session[:user_id],:item => 0,:item_id => params[:item_id],:item_uid => params[:item_uid],:item_cat_code => params[:item_cat_code],:quantity => ((params[:quantity]).to_i).abs )
        redirect_to session[:url], :flash => {:success => 'Added to cart'}
      end

    end
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

      if MyPayment.where(user_id: session[:user_id]).all.blank?
        @freight = 100
      else
        @freight = 0
      end
      total = total.to_f+@freight.to_f
      if total.to_f > 2500
        redirect_to "/review_order/"
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
    @is_pro_complete =true
    if @current_user.first_name.blank? or @current_user.last_name.blank? or @current_user.phone.blank? or @current_user.address.blank? or @current_user.city.blank? or @current_user.country.blank?
      @is_pro_complete =false
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
        data1['amount'] = catagory['Amount'].to_f % 1 == 0 ? catagory['Amount'].to_i : helpers.number_with_precision(catagory['Amount'].to_f, :precision => 2)
        data1['quantity'] = i.quantity
        data1['start_time'] = event.start_time.strftime("%I:%M %p")
        data1['end_date'] = event.end_time.strftime("%I:%M %p")
        data1['code'] = catagory['Code']
        puts "==================="
        puts data1['available'].to_i
        puts data1['quantity'].to_i
        if data1['available'].to_i < data1['quantity'].to_i
          puts "==================="
          data1['is_exceed'] = true
          @is_exceed = true
        else
          data1['is_exceed'] = false
        end
        data1['event_date'] = event.date.strftime("%d %b %y")
        data1['row_total'] = data1['quantity'].to_f*data1['amount'].to_f
        data1['row_total']= data1['row_total'].to_f % 1 == 0 ? data1['row_total'].to_i : helpers.number_with_precision(data1['row_total'].to_f, :precision => 2)
      end
      @cart_data.push(data1)
    end

    if not params[:from_cart].blank?
      @card_data={}
      @card_data['cardNumber']=params[:cardNumber]
      @card_data['cardExpiry']=params[:cardExpiry]
      @card_data['cardCVC']=params[:cardCVC]
      @card_data['cardtype']=params[:cardtype]
    end
    @total = @cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
    if MyPayment.where(user_id: session[:user_id]).all.blank?
      @freight = 100
    else
      @freight = 0
    end
    @total = @total.to_f+@freight.to_f
    @booking_total = @total
    if @total.to_f <= 2500
      @cc_amount = @total*0.025
      @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
      @total = @total.to_f+@cc_amount.to_f
    end
    @total = @total.to_f % 1 == 0 ? @total.to_i : helpers.number_with_precision(@total.to_f, :precision => 2)
  end

  def make_payment
      # delete this Code
      cart = Cart.where(:user_id => session[:user_id])
      user = User.find(session[:user_id])
      if not params[:is_user_update].blank?
        user.update(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email] ,:phone => params[:phone], :address => params[:address], :city => params[:city], :state => params[:state], :post_code => params[:post_code], :country => params[:country], :middle_name => params[:middle_name] )
      end
      @cart_data = []
      for i in cart
        data1 = {}
        if i.item == 'event'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
          data = kingdomsg_api(url)
          catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]
          event = Event.find(i.item_id)
          data1['item'] = 0
          data1['item_type'] = 'Event'
          data1['item_id'] = i.item_id
          data1['item_uid'] = i.item_uid
          data1['item_cat_code'] = i.item_cat_code
          data1['name'] = event.name+", "+catagory['Name']
          data1['available'] = catagory['Available']
          data1['amount'] = catagory['Amount']
          data1['quantity'] = i.quantity
          data1['event_date'] = event.date.strftime("%d %b %y")
        end
        @cart_data.push(data1)
      end
      total = @cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
      booking_total = total
      if MyPayment.where(user_id: session[:user_id]).all.blank?
        @freight = 100
      else
        @freight = 0
      end
      total = total.to_f+@freight.to_f
      url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/BookFunction")
      if params[:from_card].blank?
        @cc_amount = 0
        @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
        total = total.to_f+@cc_amount.to_f
        total = total.to_f % 1 == 0 ? total.to_i : helpers.number_with_precision(total.to_f, :precision => 2)
        @del_cart = Cart.where(user_id: session[:user_id])
        if MyPayment.where('order_id Is NOT NULL').last.blank?
          order_id = 1
        else
          order_id = (MyPayment.where('order_id Is NOT NULL').last.order_id)+1
        end
        c_data = @cart_data
        WelcomeEmailMailer.rate_exteted(c_data,@freight,@cc_amount,user).deliver_now
        WelcomeEmailMailer.admin_rate_exteted(c_data,@freight,@cc_amount,user).deliver_now
        pymt = MyPayment.create(user_id: session[:user_id], order_id: order_id, total: booking_total, date: Time.current.to_date,freight: @freight,cc_amount: @cc_amount)
        data =[]
        @cart_data.each do |mo|
          data1 ={}
          data1['code'] = mo['item_cat_code']
          data1['quantity'] = mo['quantity']
          data.push(data1)
          MyOrder.create(user_id: session[:user_id], item: mo['item'], item_id: mo['item_id'], item_uid: mo['item_uid'], item_cat_code: mo['item_cat_code'], quantity: mo['quantity'],rate: mo['amount'], my_payment_id: pymt.id)
        end
        response = kingdomsg_booking_api(url,data,booking_total,@freight,@cc_amount)
        if not response == "success"
          @message_res = (response.split('-').last).strip
          if @message_res == "There is insufficient function registration inventory available."
            redirect_to '/cart', :flash => {:error => "There is not enough tickets to fulfil your order."}
          else
            redirect_to '/cart', :flash => {:error => @message_res }
          end
        else
          @del_cart.destroy_all
          redirect_to '/thank_you', :flash => {:success => 'Booking Successfull'}
        end
      else
        @cc_amount = total*0.025
        @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
        total = total.to_f+@cc_amount.to_f
        total = total.to_f % 1 == 0 ? total.to_i : helpers.number_with_precision(total.to_f, :precision => 2)
        require 'paypal-sdk-rest'
        @payment = PayPal::SDK::REST::Payment.new({
              :intent => "sale",
              :payer => {
                :payment_method => "credit_card",
                :funding_instruments => [{
                  :credit_card => {
                    :type => params[:cardtype],
                    :number => params[:cardNumber].delete(' '),
                    :expire_month => params[:cardExpiry].split('/')[0].delete(' '),
                    :expire_year => params[:cardExpiry].split('/')[1].delete(' '),
                    :cvv2 => params[:cardCVC].delete(' '),
                    :first_name => user.first_name,
                    :last_name => user.last_name,
                    :billing_address => {
                      :line1 => user.address,
                      :city => user.city,
                      :state => user.state,
                      :postal_code => user.post_code,
                      :country_code => "AU" }}}]},
              :transactions => [{
                :amount => {
                  :total => total,
                  :currency => "AUD" },
                :description => "This is the payment transaction description." }]})
        # Create Payment and return the status(true or false)
        if @payment.create
          puts "done"
          puts @payment.id # Payment Id
          # my paymment update after making a payment
          @del_cart = Cart.where(user_id: session[:user_id])
          c_data = @cart_data
          WelcomeEmailMailer.shoppingdetails(c_data,@freight,@cc_amount,user,total).deliver_now
          WelcomeEmailMailer.admin_shopping_cart(c_data,@freight,@cc_amount, user,total).deliver_now
          pymt = MyPayment.create(user_id: session[:user_id], payment_id: @payment.id, total: booking_total, date: Time.current.to_date,freight: @freight,cc_amount: @cc_amount)
          data = []
          @cart_data.each do |mo|
            data1 ={}
            data1['code'] = mo['item_cat_code']
            data1['quantity'] = mo['quantity']
            data.push(data1)
            MyOrder.create(user_id: session[:user_id], item: mo['item'], item_id: mo['item_id'], item_uid: mo['item_uid'], item_cat_code: mo['item_cat_code'], quantity: mo['quantity'],rate: mo['amount'], my_payment_id: pymt.id)
          end
          response = kingdomsg_booking_api(url,data,booking_total,@freight,@cc_amount)
          puts "{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}"
          puts response
          puts response.inspect
          puts JSON.parse(response)
          puts response["Error"]
          hhit = JSON.parse(response)
          if not hhit["Error"].blank? #response == "success"
            @message_res = hhit["Error"] #(response.split('-').last).strip
            if @message_res == "There is insufficient function registration inventory available."
              redirect_to '/cart', :flash => {:error => "There is not enough tickets to fulfil your order."}
            else
              redirect_to '/cart', :flash => {:error => @message_res }
            end
            # redirect_to '/cart', :flash => {:error => @message_res }
          else
            @del_cart.destroy_all
            redirect_to '/thank_you', :flash => {:success => 'Booking Successfull'}
          end
        else
          puts "not deone"
          puts @payment.error  # Error Hash
          puts @payment.error["message"]
          # cart.each do |er|
          #   @o = ErrorCart.create(er.attributes)
          #   @o.error_message = @payment.error["message"]
          #   @o.save
          #   # ErrorCart.create(item: er.item, item_id: er.item_id, item_uid: er.item_uid, item_cat_code: er.item_cat_code, quantity: er.quantity, user_id: er.user_id, error_message: @payment.error["message"] )
          # end
          redirect_to '/cart', :flash => {:error => @payment.error["message"] }
        end
      end
    end

  def my_transaction
    @cart_count = Cart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]

      payment = MyPayment.where("user_id = ?" ,session[:user_id]).order('id desc')

      @my_payment = []
      for p in payment
        data1 = {}
        data1['id'] = p.id
        if p.payment_id.blank?
          data1['pay_type'] = 'Invoice'
          data1['pay_id'] = 'N/A'
        else
          data1['pay_type'] = 'Paypal'
          data1['pay_id'] = p.payment_id
        end
        data1['date'] = p.date
        data1['total'] = p.total
        data1['freight'] = p.freight
        data1['cc_amount'] = p.cc_amount
        data1['freight']= data1['freight'].to_f % 1 == 0 ? data1['freight'].to_i : helpers.number_with_precision(data1['freight'].to_f, :precision => 2)
        data1['cc_amount']= data1['cc_amount'].to_f % 1 == 0 ? data1['cc_amount'].to_i : helpers.number_with_precision(data1['cc_amount'].to_f, :precision => 2)
        data1['total']= data1['total'].to_f % 1 == 0 ? data1['total'].to_i : helpers.number_with_precision(data1['total'].to_f, :precision => 2)

        @my_payment.push(data1)

      end
    else
      @current_user = nil
    end
  end

  def transaction_detail
    @cart_count = Cart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      items = MyOrder.where(:my_payment_id => params[:id])
      @my_payment = []
      for i in items
        data1 = {}
        if i.item == 'event'
          event = Event.find(i.item_id)
          data1['item_type'] = 'Event'
          data1['name'] = event.name+", "+i.item_cat_code
          data1['amount'] = i.rate
          data1['quantity'] = i.quantity
          data1['event_date'] = event.date.strftime("%d %b %y")
          data1['total'] = data1['amount'].to_f*data1['quantity'].to_i
          data1['amount']= data1['amount'].to_f % 1 == 0 ? data1['amount'].to_i : helpers.number_with_precision(data1['amount'].to_f, :precision => 2)
          data1['total']= data1['total'].to_f % 1 == 0 ? data1['total'].to_i : helpers.number_with_precision(data1['total'].to_f, :precision => 2)
        end
        @my_payment.push(data1)
      end
    else
      @current_user = nil
    end
  end


  def response_url()
    @user_id = params[:user_id]
    user = User.find(session[:user_id])
    @del_cart = Cart.where(user_id: params[:user_id])
    cart = Cart.where(:user_id => session[:user_id])
    @cart_data = []
    for i in cart
      data1 = {}
      if i.item == 'event'
        url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
        data = kingdomsg_api(url)
        catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

        event = Event.find(i.item_id)
        data1['item'] = 0
        data1['item_type'] = 'Event'
        data1['item_id'] = i.item_id
        data1['item_uid'] = i.item_uid
        data1['item_cat_code'] = i.item_cat_code
        data1['name'] = event.name+", "+catagory['Name']
        data1['available'] = catagory['Available']
        data1['amount'] = catagory['Amount']
        data1['quantity'] = i.quantity
        data1['event_date'] = event.date.strftime("%d %b %y")

      end
      @cart_data.push(data1)
    end
    total = @cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
    booking_total = total
    if MyPayment.where(user_id: session[:user_id]).all.blank?
      @freight = 100
    else
      @freight = 0
    end
    total = total.to_f+@freight.to_f
    puts total
    c_data = @cart_data
    if total.to_f <= 2500
      @cc_amount = total*0.025
      @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
      total = total.to_f+@cc_amount.to_f
    else
      @cc_amount = 0
      @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
      total = total.to_f+@cc_amount.to_f
      total = total.to_f % 1 == 0 ? total.to_i : helpers.number_with_precision(total.to_f, :precision => 2)
    end
    puts "the new"
    puts total
      if MyPayment.where('order_id Is NOT NULL').last.blank?
        order_id = 1
      else
        order_id = (MyPayment.where('order_id Is NOT NULL').last.order_id)+1
      end
    if params[:message] == "success" || params[:message].blank?
      pymt = MyPayment.create(user_id: session[:user_id], order_id: order_id, total: booking_total, date: Time.current.to_date,freight: @freight,cc_amount: @cc_amount)
      @del_cart.each do |mytr|
        MyOrder.create(user_id: params[:user_id], item: mytr.item, item_id: mytr.item_id, item_uid: mytr.item_uid, item_cat_code: mytr[:item_cat_code], quantity: mytr[:quantity], my_payment_id: pymt.id)
      end
      # if @freight == 0
      #   @freight.to_i
      # else
      #   @freight.to_f
      # end
      WelcomeEmailMailer.shoppingdetails(c_data,@freight,@cc_amount,user,total).deliver_now
      WelcomeEmailMailer.admin_shopping_cart(c_data,@freight,@cc_amount, user,total).deliver_now

      @del_cart.destroy_all
      redirect_to "/thank_you", flash: { success: "Your transaction in  complete"}
    else
      puts "in else part now shit thats not suppose to happen"
      puts params[:message]
      redirect_to '/cart', flash: { error: params[:message] }
    end
    puts "::::::::::::<<<<<<<<<<<<<<<<<<<<<<<<<LLLLLLLLLLLLLLLLLLL"
    puts @user_id
    puts params[:message]
  end




end
