require 'net/https'
require 'uri'

uri = URI.parse("https://" + ENV['DOMAINS'])
http = Net::HTTP.new(uri.host, uri.port)

http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

loop do
  req = Net::HTTP::Get.new(uri.request_uri)
  res = http.request(req)
  break if res.code != '404'
  sleep(3)
end

puts "Server setup completed!"
