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
        if not Event.find_by_event_code(event_code)
            puts event_code
            Event.create(name: name,date:date,start_time:start_time,end_time:end_time,event_code:event_code,session_type:session_type,prime_event:prime_event,gender:gender,detail:detail)
        end
        puts "===============" 
        puts x
        x=x+1  
    end
    
  end


end
