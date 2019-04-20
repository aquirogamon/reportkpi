# == Schema Information
#
# Table name: cpecac_interfaces
#
#  id           :bigint(8)        not null, primary key
#  device       :string
#  port         :string
#  servicio     :string
#  gbpsrx       :float
#  gbpstx       :float
#  bps_max      :float
#  status       :float
#  last_bps_max :float
#  last_status  :float
#  crecimiento  :float
#  egressRate   :float
#  gbpsrx_95    :float
#  gbpstx_95    :float
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  index_opm    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CpecacInterface < ApplicationRecord

  after_validation :weeks_suma
  after_validation :update_bw

  def self.percentile(values, percentile)
    values_sorted = values.sort
    k = (percentile*(values_sorted.length-1)+1).floor - 1
    f = (percentile*(values_sorted.length-1)+1).modulo(1)
    return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
  end

  def self.transport_devices
    table = Array.new []
    base_url = "http://172.19.216.20:8000/api/json/device/listDevices?apiKey=96437ef89ce623f8bc6f5f89e82876c1"
    data = RestClient::Request.execute(:url => base_url , :method => :get)
    data_parsed = JSON.load(data)

    data_parsed.map do |device|
      ipaddress = device["ipaddress"]
        if (device["displayName"]).include?('AMOV')
            displayName = device["displayName"]
            statusStr = device["statusStr"]
            hash = Hash[ip: ipaddress, device: displayName, status: statusStr]
            table << hash
        end
      end
    return table
  end

  def self.transport_interfaces(ip_address)
    fqdn_addr = '&name=' + ip_address
    base_url = "http://172.19.216.20:8000/api/json/device/getInterfaces?apiKey=96437ef89ce623f8bc6f5f89e82876c1" + fqdn_addr
    data = RestClient::Request.execute(:url => base_url , :method => :get)
    data_parsed = JSON.load(data)
  end

  def self.transport_stats(ip_interface)
    fqdn_int = '&interfaceName=' + ip_interface + '&graphName=traffic&period=Lastweek'
    base_url = "http://172.19.216.20:8000/api/json/device/getInterfaceGraphs?apiKey=96437ef89ce623f8bc6f5f89e82876c1" + fqdn_int
    data = RestClient::Request.execute(:url => base_url , :method => :get)
    data_parsed = JSON.load(data)
  end

  def self.devint
    CSV.read(Rails.root + "public/cac.csv")[1..-1]
  end

  def self.statsinterfacetotal_table
  table_total = Array.new []
  extra_data = Hash.new { |hash,key| hash[key] = [] }

  devint.each { 
    |a,b,c,d| 
    keystring = a
    extra_data[keystring] = Hash[name_device: a, bw: b.to_f, servicio: c]
  }
  transport_devices.map do |cac|
    ip_interfaces = cac[:ip]
    device_devices = cac[:device]
    status_devices = cac[:status]
    data_interfaces = transport_interfaces(ip_interfaces)["interfaces"]
    if transport_interfaces(ip_interfaces)["interfaceCount"] != 0
    data_interfaces.map do |interfaces|
      if ((interfaces["displayName"]).include?('WAN')) && ((interfaces["displayName"]).exclude?('.')) && ((interfaces["displayName"]).exclude?('Vlan1'))
        ip_int = ip_interfaces
        device_int = device_devices
        port_int = interfaces["displayName"]
        index_int = interfaces["ifIndex"]
        deviceindex_int = device_int + index_int
        name_int = interfaces["name"]
        servicio = extra_data[ip_int][:servicio]
        speed = ((interfaces["outSpeed"]).gsub(/[ M]/, '')).to_i
        data_stats = transport_stats(name_int)

        if (data_stats["Tx Traffic"]) != nil
          data = data_stats["Tx Traffic"].map { |h| h["y"] }
          tx_max = ((data.sort.last)/1000000).round(2)
          tx_per95 = ((percentile(data, 0.95))/1000000).round(2)
        else
          tx_max = 0
          tx_per95 = 0
        end

        if (data_stats["Rx Traffic"]) != nil
          data = data_stats["Rx Traffic"].map { |h| h["y"] }
          rx_max = ((data.sort.last)/1000000).round(2)
          rx_per95 = ((percentile(data, 0.95))/1000000).round(2)
        else
          rx_max = 0
          rx_per95 = 0
        end

        if tx_max > rx_max
          bps_max_int = tx_max
        else
          bps_max_int = rx_max
        end

        if tx_per95 > rx_per95
          bps_max_int_95 = tx_per95
        else
          bps_max_int_95 = rx_per95
        end

        if extra_data[ip_int][:bw] != 0
          status_max = ((bps_max_int/(1.024*(extra_data[ip_int][:bw])))*100).round(2)
          egresstotal = extra_data[ip_int][:bw]
        else
          status_max = ((bps_max_int/speed)*100).round(2)
          egresstotal = speed
        end

        hash = Hash[index_opm: name_int, device: device_int, port: port_int, gbpstx: tx_max, gbpstx_95: tx_per95, gbpsrx: rx_max, gbpsrx_95: rx_per95, bps_max: bps_max_int, status: status_max, egressRate: egresstotal, deviceindex: deviceindex_int, servicio: servicio, bps_max_int_95: bps_max_int_95]
        table_total << hash
      end
    end
    end
  end
  return table_total.sort! { |a,b| b[:status_max] <=> a[:status_max] }
  end

  def self.statsinterfacecrecimiento_table
   @tablecrecimiento = Array.new []
   table_last_cpecacinterface = CpecacInterface.all
   #table_last_cpecacinterface = CpecacInterface.where(created_at: (CpecacInterface.maximum(:created_at) - 30.minutes)..CpecacInterface.maximum(:created_at))
   statsinterfacetotal_table.map do |statstotal|
    device = statstotal[:device]
    port = statstotal[:port]
    gbpsrx = statstotal[:gbpsrx]
    gbpstx = statstotal[:gbpstx]
    gbpsrx_95 = statstotal[:gbpsrx_95]
    gbpstx_95 = statstotal[:gbpstx_95]
    bps_max_95_pre = statstotal[:bps_max_int_95]
    bps_max_pre = statstotal[:bps_max]
    egressRate_pre = statstotal[:egressRate]
    deviceindex = statstotal[:deviceindex]
    index_opm = statstotal[:index_opm]

    array_last_cpecacinterface = table_last_cpecacinterface.select{|last_cpecacinterface| deviceindex == last_cpecacinterface[:deviceindex]}
          if array_last_cpecacinterface != []
            @egressRate = last_cpecacinterface[:egressRate]
            status_pre = ((bps_max_95_pre/@egressRate)*100).round(2)
            if status_pre > 100.00
              @bps_max = @egressRate
              @status = 100.00
            else
              @bps_max = bps_max_95_pre
              @status = status_pre
            end
          else
            @egressRate = egressRate_pre
            status_pre = ((bps_max_95_pre/@egressRate)*100).round(2)
            if status_pre > 100.00
              @bps_max = @egressRate
              @status = 100.00
            else
              @bps_max = bps_max_95_pre
              @status = status_pre
            end
          end

          if array_last_cpecacinterface != []
            array_last_cpecacinterface.map{|last_cpecacinterface|
              @comment = last_cpecacinterface[:comment]
          }
          else
            @comment = "-"
          end
          if array_last_cpecacinterface != []
            array_last_cpecacinterface.map{|last_cpecacinterface|
              @time = last_cpecacinterface[:time]
          }
          else
            @time = "-"
          end
          if array_last_cpecacinterface != []
            array_last_cpecacinterface.map{|last_cpecacinterface|
              @servicio = last_cpecacinterface[:provider_id]
          }
          else
            @servicio = "-"
          end
          if array_last_cpecacinterface != []
            array_last_cpecacinterface.map{|last_cpecacinterface|
              @servicio = last_cpecacinterface[:servicio]
          }
          else
            @servicio = "-"
          end
          if array_last_cpecacinterface != []
            array_last_cpecacinterface.map{|last_cpecacinterface|
              @last_status = last_cpecacinterface[:status]
              @last_bps_max = last_cpecacinterface[:bps_max]
              if @last_bps_max != 0
                @crecimiento = (((bps_max - @last_bps_max)/@last_bps_max) * 100.00).round(2)
              else
                @crecimiento = 0
              end
          }
          else
            @last_status = 0
            @last_bps_max = 0
            @crecimiento = 0
          end
          if (array_last_cpecacinterface != []) and (status > 84.99)
            array_last_cpecacinterface.map{|last_cpecacinterface|
              @weeks = last_cpecacinterface[:weeks] + 1
          }
          else
            @weeks = 0
          end

       hash = Hash[device: device, 
                  port: port, 
                  servicio: @servicio, 
                  gbpsrx: gbpsrx, 
                  gbpstx: gbpstx, 
                  gbpsrx_95: gbpsrx_95, 
                  gbpstx_95: gbpstx_95, 
                  bps_max: @bps_max, 
                  last_bps_max: @last_bps_max, 
                  last_status: @last_status, 
                  crecimiento: @crecimiento, 
                  weeks: @weeks, 
                  status: @status, 
                  egressRate: @egressRate, 
                  comment: @comment, 
                  time: @time, 
                  deviceindex: deviceindex, 
                  index_opm: index_opm]
      @tablecrecimiento << hash
   end
   return @tablecrecimiento.sort! { |a,b| b[:status] <=> a[:status] }
  end

  private

  def weeks_suma
    if self.status > 84.99
      self.weeks = self.weeks + 1
    else
      self.weeks = 0
    end
  end

  def update_bw
    self.status = ((self.bps_max / self.egressRate)*100).round(2)
  end

end
