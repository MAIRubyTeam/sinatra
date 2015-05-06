require 'net/http'
require 'openssl'


uri = URI.parse("http://127.0.0.1:9393/Pacient/78789")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.scheme == "https"
http.verify_mode = OpenSSL::SSL::VERIFY_NONE #не проверять сертификат

http.start do |http_request|
  res = http_request.send_request("GET",
    uri.request_uri,
    URI.encode_www_form('data[quantity]' => 4, 'data[order_id]' => 128216415))

  res_txt = res.body

  puts res.inspect

  puts res_txt

end