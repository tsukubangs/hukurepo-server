require 'net/https'
require 'uri'

uristr = "https://" + ENV['DOMAINS']
uri = URI.parse(uristr)
http = Net::HTTP.new(uri.host, uri.port)

http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

count = 0

loop do
  begin
    req = Net::HTTP::Get.new(uri.request_uri)
  rescue
  end
    res = http.request(req)

    break if res.code == '200' || count > 99
    count += 1
  puts "Connect #{uristr} ...(#{count} times)"
  sleep(3)
end

STDOUT.flush
STDOUT.sync

if count > 99
  puts "Server Setup Failed"
else
  puts "Server Setup Completed"
end

