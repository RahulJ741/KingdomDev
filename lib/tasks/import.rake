require 'csv'
namespace :import do
  desc "Rake task to get events data"
  
  task :events => [:environment] do
    Rails.logger.level = Logger::DEBUG
    file = "event_data.csv"
    x=1
    CSV.foreach(file, :headers => true) do |row|
        name =  row['Function Group']
        date = Date.parse(row['Date'])
        start_time = DateTime.parse(row['Date']+" "+row['Start Time'])
        end_time = DateTime.parse(row['Date']+" "+row['End Time'])
        event_code = row['Item without Cat']
        session_type = row['Session Type']
        prime_event = row['Prime Event']
        gender = row['Gender']
        detail = row['Details']
        venue = row['Venue']
        event = Event.find_by_event_code(event_code)
        if not event
            puts event_code
            Event.create(name: name,date:date,start_time:start_time,end_time:end_time,event_code:event_code,session_type:session_type,prime_event:prime_event,gender:gender,detail:detail,venue:venue)
        end
        puts "===============" 
        puts x
        x=x+1  
    end
  end

  task :hotels => [:environment] do
    Rails.logger.level = Logger::DEBUG
    file = "hotel_data.csv"
    x=1
    CSV.foreach(file, :headers => true) do |row|
        name =  row['Hotel']
        # puts row['Hotel']
        hotel = Hotel.find_by_name(name)
        if hotel
          puts hotel.name
          hotel_id = hotel.id
          room_type = row['Room Type']
          room_code = row['Item Code']
          check_in_date = Date.parse(row['Check In Date'])
          check_out_date = Date.parse(row['Check Out Date'])
          max_person = row['Pax']
          no_of_night = row['Nights']
          rate = (row['Daily Rate'].gsub('$','').strip).gsub(',','')
          Room.create(hotel_id: hotel.id,room_type: room_type,room_code:room_code,check_in_date: check_in_date,check_out_date: check_out_date,max_person: max_person,no_of_night: no_of_night,rate: rate)
        end

        
       
        puts "===============" 
        puts x
        x=x+1  
    end
    
  end


end
