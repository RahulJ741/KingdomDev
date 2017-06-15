class EventController < ApplicationController
  
  def index
    url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctions")
    data = kingdomsg_api(url)
    
    puts "==========="
    @events = []
    for i in data['Functions']
        event = Event.find_by_event_code(i['Code'])
        if event
	        data1 = {}
	        data1['name'] = event.name
	        data1['venue'] = event.venue
	        data1['gender'] = event.gender
	        data1['date'] = event.date.strftime("%d %b %y") 
	        data1["time"] = event.start_time.strftime("%I:%M %p")+" - "+event.end_time.strftime("%I:%M %p")
	        data1['event_id'] = event.id
	        data1['event_uid'] = i['Id']
	        # data1['cat'] =[]
	        # for j in i['FeeTypes']
	        #   data2 ={}
	        #   data2['name'] = j['Name']
	        #   data2['rate'] = j['Amount']
	        #   data1['cat'].push(data2)
	        # end
	        @events.push(data1)
	    end

    end
    puts @events.count
	puts data['Functions'].count
    @all_events = @events.map { |h| h['name'] }.uniq

    # if not params[:event].blank?
    #   @events = @events.select {|a| a["name"] == params[:event] }
    # end

    # if not params[:start_date].blank?
    #   @events = @events.select {|a| a["date"] == params[:start_date][0..4] }
    # end


    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = HotelShoppingCart.where(:user_id => session[:user_id]).count + EventShoppingCart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end
end
