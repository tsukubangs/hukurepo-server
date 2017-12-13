require 'net/https'
require 'uri'

STDOUT.flush
STDOUT.sync

uristr = "https://" + ENV['DOMAINS']
uri = URI.parse(uristr)
http = Net::HTTP.new(uri.host, uri.port)

http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

count = 0

puts "サーバプログラムを起動しています。数分間お待ち下さい。"

loop do
  code = ''
  begin
    req = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(req)
    code = res.code
  rescue
  end
    break if code == '200' || count > 200
    count += 1
    print "."
    sleep(3)
end

puts ""

puts   "---------------------------------------"
if count > 200
  puts "サーバプログラムの起動に失敗しました"
else
  puts "サーバプログラムの起動に成功しました！"
end
puts   "---------------------------------------"
