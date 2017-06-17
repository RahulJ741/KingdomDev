class EventController < ApplicationController
  
  def index
    if params[:event].blank?
      url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctions")
    else
      url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctions?group="+params[:event])
    end
   
    data = kingdomsg_api(url)
    puts data
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
	        data1['event_code'] = i['Code']
	        amt  =[]
	        for j in i['FeeTypes']
	           
	          amt.push(j['Amount'])
	        end
	        data1['start_rate'] = amt.min.to_i
	        @events.push(data1)
	    end

    end
    puts @events.count
	  puts data['Functions'].count
    
    url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionGroups")
    data = kingdomsg_api(url)
    @all_events = (data['FunctionGroups'].pluck('Name')).sort
   
    puts @all_events.count
    # if not params[:event].blank?
    #   @events = @events.select {|a| a["name"] == params[:event] }
    # end

    # if not params[:start_date].blank?
    #   @events = @events.select {|a| a["date"] == params[:start_date][0..4] }
    # end


    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = Cart.where(:user_id => session[:user_id]).count
    else
      @current_user = nil
    end
  end

  def show
  	url = URI("https://kingdomsg.eventsair.com/ksgapi/gc2018/tour/ksgapi/GetFunctionInfo?functionid="+params[:event_uid])
    data = kingdomsg_api(url)
    @event = Event.find_by_event_code(data['FunctionInfo']['Code'])
    @event_cats = data['FunctionInfo']['FeeTypes']
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @cart_count = Cart.where(:user_id => session[:user_id]).count 
    else
      @current_user = nil
    end
  end

end