class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'uri'
  require 'net/http'
  def kingdomsg_api(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request1 = Net::HTTP::Get.new(url)
    request1["apikey"] = 'wmQ87NZhMvWx5ZvrrStJPr9FG9WQ0wOSGVXxbUKDbjAuZC6k42M3x9GOzFt2umSQhRGylMwmBmlcU'
    request1["appusername"] = 'aaa@aaa.com'
    request1["apppassword"] = 'aaa@aaa.com'
    request1["content-type"] = 'application/json'

    response = http.request(request1)
    # puts response.read_body
    data = JSON.parse(response.body)
    return data
  end

  def kingdomsg_booking_api(url,data)
    user = User.find(session[:user_id])
    payload = {}
    payload["ContactComponentSubmission"]={}
    payload["ContactComponentSubmission"]["FirstName"] = user.first_name
    payload["ContactComponentSubmission"]["MiddleName"] = user.middle_name
    payload["ContactComponentSubmission"]["email"] = user.email
    payload["ContactComponentSubmission"]["Organization"] = "Centium Software"
    payload["ContactComponentSubmission"]["AddressLineOne"] = user.address
    payload["ContactComponentSubmission"]["City"] = user.city
    payload["ContactComponentSubmission"]["State"] = user.state
    payload["ContactComponentSubmission"]["Postcode"] = user.post_code
    payload["ContactComponentSubmission"]["Country"] = user.country
    payload["Functions"] = []
    for i in data
      data1 ={}
      data1["UniqueFunctionCode"] = i["code"]
      data1["FunctionPaycode"] = "No Charge"
      data1["NoTickets"] = i["quantity"].to_i
      payload["Functions"].push(data1) 
    end

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request1 = Net::HTTP::Get.new(url)
    request1["apikey"] = 'wmQ87NZhMvWx5ZvrrStJPr9FG9WQ0wOSGVXxbUKDbjAuZC6k42M3x9GOzFt2umSQhRGylMwmBmlcU'
    request1["appusername"] = 'aaa@aaa.com'
    request1["apppassword"] = 'aaa@aaa.com'
    request1["content-type"] = 'application/json'
    puts data.to_json
    request1.body= payload.to_json
    
    response = http.request(request1)
    data = response.body
    return data
  end

 

end
