  def self.transport_stats_test(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=lastHour&intervalTypeKey=QUARTER_HOUR&maxPageSize=200000" + fqdn
    #base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=QUARTER_HOUR&maxPageSize=200000" + fqdn
    begin
      data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
    data_parsed = JSON.load(data)["report"]["data"]
  end

  def self.devint
    interface_array = CSV.read(Rails.root + "public/core.csv")[1..-1]
  end

   @not_found = Array.new []
   @yes_found = Array.new []
   tablemax = Array.new []
   devint.each do |devint|
    devicemax = devint[0]

    data_stats = Hash.new { |hash, key| hash[key] = [] }

    if transport_stats_test(devint[1]) != []
      @yes_found << [devint[1]]
    else
      @not_found << [devint[1]]
    end
   end

puts "Devices found: " + @yes_found.to_s
puts "Devices not found: " + @not_found.to_s
