class ShoppingCartController < ApplicationController
  require 'date'
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
        elsif i.item = 'package'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetPackage?packageid="+i.item_uid)
          data = kingdomsg_api(url)
          puts "???????????????????"
          puts data
          pack = data['Package']
          data1['cart_id'] = i.id
          data1['item_type'] = 'Package'
          data1['name'] = pack['PackageGroupName']+ " " +pack['Functions'].first['FunctionGroupName']
          data1['amount'] = pack['PackageAmount']
          data1['quantity'] = 1
          data1['event_date'] = DateTime.parse(pack['HotelRooms'][0]['Range'].first['Date']).strftime("%d %b %y")+ " - " +DateTime.parse(pack['HotelRooms'][0]['Range'].last['Date']).strftime("%d %b %y")
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


  def package_add_cart
    @cart = Cart.find_by_item_uid_and_user_id(params[:item_uid], session[:user_id])
    if @cart.present?
      redirect_to :back, :flash => {:error => "Package already present in cart"}
    else
      if params[:user_id].blank? or params[:item_uid].blank?
        redirect_to :back, :flash => {:error => "Package cannot be added to cart"}
      else
        Cart.create(user_id: session[:user_id], item_uid: params[:item_uid], item: 2)
        redirect_to :back, :flash => {:success => "Package added"}
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
        elsif i.item = 'package'
          url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetPackage?packageid="+i.item_uid)
          data = kingdomsg_api(url)
          puts "???????????????????"
          puts data
          pack = data['Package']
          data1['cart_id'] = i.id
          data1['item_type'] = 'Package'
          data1['name'] = pack['PackageGroupName']+ " " +pack['Functions'].first['FunctionGroupName']
          data1['amount'] = pack['PackageAmount']
          data1['quantity'] = 1
          data1['event_date'] = DateTime.parse(pack['HotelRooms'][0]['Range'].first['Date']).strftime("%d %b %y")+ " - " +DateTime.parse(pack['HotelRooms'][0]['Range'].last['Date']).strftime("%d %b %y")
        end
        @cart_data.push(data1)
        # end
        # @cart_data.push(data1)
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
      # end
      # @cart_data.push(data1)
    elsif i.item = 'package'
      url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetPackage?packageid="+i.item_uid)
      data = kingdomsg_api(url)
      puts "???????????????????"
      puts data
      pack = data['Package']
      data1['cart_id'] = i.id
      data1['item_type'] = 'Package'
      data1['name'] = pack['PackageGroupName']+ " " +pack['Functions'].first['FunctionGroupName']
      data1['amount'] = pack['PackageAmount']
      data1['quantity'] = 1
      data1['event_date'] = DateTime.parse(pack['HotelRooms'][0]['Range'].first['Date']).strftime("%d %b %y")+ " - " +DateTime.parse(pack['HotelRooms'][0]['Range'].last['Date']).strftime("%d %b %y")
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
    cart = Cart.where(:user_id => session[:user_id])

    user = User.find(session[:user_id])
    if not params[:is_user_update].blank?
      user.update(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email] ,:phone => params[:phone], :address => params[:address], :city => params[:city], :state => params[:state], :post_code => params[:post_code], :country => params[:country], :middle_name => params[:middle_name] )
    end
    @event_cart_data = []
    @package_cart_data = []
    for i in cart

      if i.item == 'event'
        url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+i.item_uid)
        data = kingdomsg_api(url)
        catagory =  (data['FunctionInfo']['FeeTypes'].select {|cat| cat["Code"] == i.item_cat_code })[0]

        event = Event.find(i.item_id)
        data1 = {}
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
        @event_cart_data.push(data1)
      elsif i.item == 'package'
        url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetPackage?packageid="+i.item_uid)
        data = kingdomsg_api(url)
        puts "???????????????????"
        puts data
        pack = data['Package']
        data1 = {}
        data1['cart_id'] = i.id
        data1['item_type'] = 'Package'
        data1['name'] = pack['PackageGroupName']+ " " +pack['Functions'].first['FunctionGroupName']
        data1['amount'] = pack['PackageAmount']
        data1['quantity'] = pack['HotelRooms'][0]['MaxOccupancy']
        data1['event_date'] = DateTime.parse(pack['HotelRooms'][0]['Range'].first['Date']).strftime("%d %b %y")+ " - " +DateTime.parse(pack['HotelRooms'][0]['Range'].last['Date']).strftime("%d %b %y")
        data1['package_name'] = pack['Name']
        data1['unique_package_code'] = pack["UniquePackageCode"]
        data1['max_people'] = ['HotelRooms'][0]['MaxOccupancy']
        data1['Hotel_Room'] = []
        data1['Functions'] = []
        pack['HotelRooms'].each do |gi|
          data3 = {}
          data3['Room_name'] = gi['Code']

          data3['Check_in_date'] = gi['Range'][0]['Date'].first
          @date_changes = gi['Range'][0]['Date'].last.strip('/')
          @date_changed = (@date_changes.first.to_i) + 1
          @date_changes = @date_changed.to_s+"/"+@date_changes[1]+"/"+@date_changes[2]
          data3['Check_out_date'] = @date_changes
          data1['Hotel_Room'].push(data3)
        end
        pack['Functions'].each do |func|
          data4 = {}
          data4['Function_code'] = func['Code']
          data1['Function'].push(data4)
        end
        @package_cart_data.push(data1)
      end

    end
    #for ewvent
    if not @event_cart_data.blank?
      total = @event_cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
      booking_total = total
      if MyPayment.where(user_id: session[:user_id]).all.blank?
        @freight = 100
      else
        @freight = 0
      end
      total = total.to_f+@freight.to_f
      puts total

      url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/BookFunction")

      puts "the url is mofu:"
      puts url

        @cc_amount = total*0.025
        @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
        total = total.to_f+@cc_amount.to_f
        total = total.to_f % 1 == 0 ? total.to_i : helpers.number_with_precision(total.to_f, :precision => 2)

        data = []
        @event_cart_data.each do |mo|
            data1 ={}
            data1['code'] = mo['item_cat_code']
            data1['quantity'] = mo['quantity']
            data.push(data1)

        end

        response = kingdomsg_booking_api(url,data,booking_total,@freight,@cc_amount)
      end
      
      if not @package_cart_data.blank?
        total = @package_cart_data.map {|s| s['amount'].to_f * s['quantity'].to_f}.reduce(0, :+)
        booking_total = total
        # if MyPayment.where(user_id: session[:user_id]).all.blank?
        #   @freight = 100
        # else
        #   @freight = 0
        # end
        # total = total.to_f+@freight.to_f
        puts total

        url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/BookFunction")

        puts "the url is mofu:"
        puts url

          # @cc_amount = total*0.025
          # @cc_amount = @cc_amount.to_f % 1 == 0 ? @cc_amount.to_i : helpers.number_with_precision(@cc_amount.to_f, :precision => 2)
          # total = total.to_f+@cc_amount.to_f
          # total = total.to_f % 1 == 0 ? total.to_i : helpers.number_with_precision(total.to_f, :precision => 2)

          # data = []
          # @package_cart_data.each do |mo|
          #     data1 ={}
          #     # data1['code'] = mo['item_cat_code']
          #     # data1['quantity'] = mo['quantity']
          #     data1['Hotel_Room']
          #     data1['Functions']
          #
          #     data.push(data1)
          #
          # end

          response = package_booking_api(url,@package_cart_data,booking_total)
        end
      puts "_________________++++++++++++++++++++++_________________"
      puts response
      puts response["Error"]
      hhit = JSON.parse response
      puts hhit
      puts "_________________++++++++++++++++++++++_________________"
      if not hhit["Error"].blank?
        puts hhit["Error"]
        puts "Error ^^^^^^^^^^^^^^^^^^^^^^"
        redirect_to session[:previous_url], flash:{:error => hhit["Error"]}
      else

        redirect_to hhit["PaymentUrl"]
      end

    # end

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
