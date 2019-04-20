# == Schema Information
#
# Table name: core_interfaces
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
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  location     :string
#  router       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  provider_id  :bigint(8)        default(4)
#

class CoreInterface < ApplicationRecord

  belongs_to :provider
  after_validation :weeks_suma
  after_validation :update_automatic

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    #base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=last6Hours&intervalTypeKey=HOUR&maxPageSize=200000" + fqdn
    base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=last3Days&intervalTypeKey=QUARTER_HOUR&maxPageSize=200000" + fqdn
    begin
      data = RestClient::Request.execute(:url => base_url , :method => :get, :verify_ssl => false)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
    if (data != nil) and (data != "")
      data = JSON.load(data)["report"]["data"]
    else
      data = nil
    end
    return data
  end

  def self.devint
    CSV.read(Rails.root + "public/core.csv")[1..-1]
  end


  def self.statsinterfacetotal_table

    @table = Hash.new { |hash, key| hash[key] = [] }
    @table_total = Array.new []
    @not_found = Array.new []

    devices = Array.new []
    extra_data = Hash.new { |hash,key| hash[key] = [] }
    interfaces = Hash.new { |hash,key| hash[key] = [] }

    devint.each { 
      |a,b,c,d,e,f,g,h,i,j,k,l| interfaces[a] << [c,d.to_f]
      unless devices.include? [a,b]
        devices << [a,b]      
      end
      keystring = a + c
      extra_data[keystring] = Hash[bw: d.to_f, servicio_total: e.to_s, router_total: f.to_s, location_total: g.to_s]
    }
    
    data = Hash.new { |hash, key| hash[key] = [] }

    devices.map do |device|
      data[device[0]] = transport_stats(device[1])
      data_test = transport_stats(device[1])
      if (data_test != nil) and (data_test != [])
      data[device[0]].map do |item|
        interfaces[device[0]].map do |interface|
         if item[3].include? interface[0]
            hash1 = Hash[bps_tx: item[7].gsub(/,/, '').to_f, bps_rx: item[8].gsub(/,/, '').to_f, int_total: item[0], status_tx: item[5].gsub(/,/, '').to_f, status_rx: item[6].gsub(/,/, '').to_f, egress: item[4].gsub(/,/, '').to_f]
            keystring = (device[0].to_s + item[3].to_s).to_s
            @table[keystring] << hash1
         end
        end
      end
      end
    end

    devices.each do |device|
      interfaces[device[0]].each do |interface|
        keystring = (device[0].to_s + interface[0].to_s).to_s
        if @table[keystring] != []
          maxtx = ((@table[keystring].sort { |a,b| a[:bps_tx] <=> b[:bps_tx] }.last[:bps_tx])/1000000000).round(2)
          maxrx = ((@table[keystring].sort { |a,b| a[:bps_rx] <=> b[:bps_rx] }.last[:bps_rx])/1000000000).round(2)
          if maxtx > maxrx
            maxbps = maxtx
          else
            maxbps = maxrx
          end
          if extra_data[keystring][:bw] != 0
            maxstatustx = ((maxtx/(extra_data[keystring][:bw]))*100).round(2)
            maxstatusrx = ((maxrx/(extra_data[keystring][:bw]))*100).round(2)
            egresstotal = extra_data[keystring][:bw]
          else
            maxstatustx = ((@table[keystring].sort { |a,b| a[:status_tx] <=> b[:status_tx] }.last[:status_tx])).round(2)
            maxstatusrx = ((@table[keystring].sort { |a,b| a[:status_rx] <=> b[:status_rx] }.last[:status_rx])).round(2)
            egresstotal = ((@table[keystring].sort { |a,b| a[:egress] <=> b[:egress] }.last[:egress])/1000000000).round(2)
          end
          if maxstatustx > maxstatusrx
            maxstatus = maxstatustx
          else
            maxstatus = maxstatusrx
          end
          int = @table[keystring].first[:int_total]

          hash2 = Hash[device_total: device[0], 
            port_total: int, 
            gbpstx_total: maxtx, gbpsrx_total: maxrx, 
            bps_max_total: maxbps, status_total: maxstatus, 
            servicio_total: extra_data[keystring][:servicio_total], 
            router_total: extra_data[keystring][:router_total], 
            location_total: extra_data[keystring][:location_total], 
            egressRate_total: egresstotal, 
            deviceindex_total: keystring]
          @table_total << hash2
        #else
       #   @not_found << [device,interface]
        end
      end
    end

    #puts "Devices not found: " + @not_found.to_s
    return @table_total.sort! { |a,b| b[:status_total] <=> a[:status_total] }

  end

  def self.statsinterfacecrecimiento_table
   @tablecrecimiento = Array.new []
   table_last_coreinterface = (CoreInterface.where(CoreInterface.arel_table[:created_at].gt(CoreInterface.maximum(:created_at).to_date)))
   statsinterfacetotal_table.map do |statstotal|
    device = statstotal[:device_total]
    port = statstotal[:port_total]
    egressRate = statstotal[:egressRate_total]
    gbpsrx = statstotal[:gbpsrx_total]
    gbpstx = statstotal[:gbpstx_total]
    #servicio = statstotal[:servicio_total]
    #router = statstotal[:router_total]
    #location = statstotal[:location_total]
    deviceindex = statstotal[:deviceindex_total]

    if statstotal[:status_total] > 100.00
      status = 100.00
      bps_max = egressRate
    else
      bps_max = statstotal[:bps_max_total]
      status = statstotal[:status_total]
    end


      array_last_coreinterface = table_last_coreinterface.select{|last_coreinterface| deviceindex == last_coreinterface[:deviceindex]}
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @comment = last_coreinterface[:comment]
          }
          else
            @comment = "-"
          end
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @time = last_coreinterface[:time]
          }
          else
            @time = "-"
          end
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @provider_id = last_coreinterface[:provider_id]
          }
          else
            @provider_id = 4
          end
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @router = last_coreinterface[:router]
          }
          else
            @router = "-"
          end
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @location = last_coreinterface[:location]
          }
          else
            @location = "-"
          end
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @servicio = last_coreinterface[:servicio]
          }
          else
            @servicio = "-"
          end
          if array_last_coreinterface != []
            array_last_coreinterface.map{|last_coreinterface|
              @last_status = last_coreinterface[:status]
              @last_bps_max = last_coreinterface[:bps_max]
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
          if (array_last_coreinterface != []) and (status > 84.99)
            array_last_coreinterface.map{|last_coreinterface|
              @weeks = last_coreinterface[:weeks] + 1
          }
          else
            @weeks = 0
          end
       hash = Hash[device: device, 
                  router: @router, 
                  location: @location, 
                  port: port, 
                  servicio: @servicio, 
                  gbpsrx: gbpsrx, 
                  gbpstx: gbpstx, 
                  bps_max: bps_max, 
                  last_bps_max: @last_bps_max, 
                  last_status: @last_status, 
                  crecimiento: @crecimiento, 
                  weeks: @weeks, 
                  status: status, 
                  egressRate: egressRate, 
                  comment: @comment, 
                  time: @time, 
                  provider_id: @provider_id, 
                  deviceindex: deviceindex]
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

  def update_automatic
    self.status = ((self.bps_max / self.egressRate)*100).round(2)
    self.crecimiento = (((self.bps_max - self.last_bps_max)/self.last_bps_max)*100).round(2)
  end

end
