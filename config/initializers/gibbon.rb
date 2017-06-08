# require 'gibbon'
# Gibbon::API.api_key = ENV["MAILCHIMP_API_KEY"]
# Gibbon::API.timeout = 15
# Gibbon::API.throws_exceptions = true
# puts "MailChimp API key: #{Gibbon::API.api_key}"
# Rails.configuration.mailchimp = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
Gibbon::Request.api_key = ENV["MAILCHIMP_API_KEY"]
Gibbon::Request.timeout = 15
Gibbon::Request.throws_exceptions = false
puts "MailChimp API key: #{Gibbon::Request.api_key}"
