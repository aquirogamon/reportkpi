# == Schema Information
#
# Table name: preagg_interfaces
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
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  provider_id  :bigint(8)        default(4)
#

class PreaggInterface < ActiveRecord::Base

  belongs_to :provider

  def self.transport_stats(ip_address)
    fqdn = '&FQDN=Node%3D' + ip_address
    #base_url = "https://aquiroga:Cl4r0peru51@172.19.212.8:4440/ppm/rest/reports/Transport+Statistics/Interface/Interface+Utilization%2FBit+Rates?outputType=jsonv2&durationSelect=lastDay&intervalTypeKey=HOUR&maxPageSize=200000" + fqdn
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
    interface_array = CSV.read(Rails.root + "public/preagg.csv")[1..-1]
  end


  def self.statsinterfacemax_table
   tablemax = Array.new []
   devint.each do |devint|
    devicemax = devint[0]

    data_stats = Hash.new { |hash, key| hash[key] = [] }
    data_stats = transport_stats(devint[1])

    if data_stats != nil
    data_stats.map do |stats_device|
    if ((stats_device[0]).exclude?('Vlan')) && ((stats_device[0]).exclude?('BDI'))
      bps_txmax = ((stats_device[7].gsub(/,/, '').to_f)/1000000000).round(2)
      bps_rxmax = ((stats_device[8].gsub(/,/, '').to_f)/1000000000).round(2)
      status_txmax = (stats_device[5].gsub(/,/, '').to_f).round(2)
      status_rxmax = (stats_device[6].gsub(/,/, '').to_f).round(2)
      egressRatemax = (stats_device[4].gsub(/,/, '').to_f)/1000000000
      indexmax = stats_device[3]
      portmax = stats_device[0]
      device_int_stats_max = (devicemax+indexmax).to_s

       if bps_rxmax > bps_txmax
        totalbps_max = bps_rxmax
       else
        totalbps_max = bps_txmax
       end
       if status_rxmax > status_txmax
        status_max = status_rxmax
       else
        status_max = status_txmax
       end

       hash = Hash[devicemax: devicemax, portmax: portmax, egressRatemax: egressRatemax, totalbps_max: totalbps_max, bps_rxmax: bps_rxmax, bps_txmax: bps_txmax, status_max: status_max, status_rxmax: status_rxmax, status_txmax: status_txmax, device_int_stats_max: device_int_stats_max]
       tablemax << hash
    end
    end
    end
   end
   return tablemax.group_by{ |x| x[:device_int_stats_max] }.values.map{ |gp| gp.max_by{ |st| st[:status_max] }}.sort! { |a,b| b[:status_max] <=> a[:status_max] }
  end

  def self.statsinterfacecrecimiento_table
   @tablecrecimiento = Array.new []
   statsinterfacemax_table.map do |statstotal|
    device = statstotal[:devicemax]
    port = statstotal[:portmax]
    egressRate = statstotal[:egressRatemax]
    gbpsrx = statstotal[:bps_rxmax]
    gbpstx = statstotal[:bps_txmax]
    deviceindex = statstotal[:device_int_stats_max]

    if statstotal[:status_max] > 100.00
      status = 100.00
      bps_max = egressRate
    else
      bps_max = statstotal[:totalbps_max]
      status = statstotal[:status_max]
    end

      (PreaggInterface.where(PreaggInterface.arel_table[:created_at].gt(PreaggInterface.maximum(:created_at).to_date))).map do |crecimiento|
        if crecimiento[:deviceindex] == deviceindex
          if ((crecimiento[:comment]) != "-") and ((crecimiento[:comment]) != nil)
            @comment = crecimiento[:comment]
          elsif (crecimiento[:servicio]) == "ACCESO"
          	@comment = "Interface de Acceso"
          else	
            @comment = '-'
          end
          if ((crecimiento[:time]) != 0) and ((crecimiento[:time]) != nil)
            @time = crecimiento[:time]
          else  
            @time = '-'
          end
          if ((crecimiento[:servicio]) != 0) and ((crecimiento[:servicio]) != nil)
            @servicio = crecimiento[:servicio]
          else  
            @servicio = '-'
          end
          if (crecimiento[:provider_id]) != nil
            @provider_id = crecimiento[:provider_id]
          else  
            @provider_id = 4
          end
          if (crecimiento[:status]) != 0
            @last_status = crecimiento[:status]
            @last_bps_max = crecimiento[:bps_max]
            @crecimiento = (((bps_max - @last_bps_max)/@last_bps_max) * 100.00).round(2)
          else
            @crecimiento = 0
            @last_bps_max = 0
            @last_status = 0
          end
          break
        else
          @crecimiento = 0
          @last_bps_max = 0
          @last_status = 0
        end
      end
       hash = Hash[device: device, 
                  port: port, 
                  servicio: @servicio, 
                  gbpsrx: gbpsrx, 
                  gbpstx: gbpstx, 
                  bps_max: bps_max, 
                  last_bps_max: @last_bps_max, 
                  last_status: @last_status, 
                  crecimiento: @crecimiento, 
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

end
