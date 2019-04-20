# == Schema Information
#
# Table name: ipranedge_interfaces
#
#  id           :bigint(8)        not null, primary key
#  devicea      :string
#  porta        :string
#  descriptiona :string
#  egressRate   :float
#  speed        :string
#  gbpsrx       :float
#  gbpstx       :float
#  last_bps_max :float
#  last_status  :float
#  bps_max      :float
#  status       :float
#  crecimiento  :float
#  time         :date
#  comment      :text
#  weeks        :integer          default(0)
#  deviceindex  :string
#  name_devicea :string
#  deviceb      :string
#  portb        :string
#  name_deviceb :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  provider_id  :bigint(8)        default(4)
#

class IpranedgeInterface < ApplicationRecord

  belongs_to :provider
  after_validation :weeks_suma
  after_validation :update_automatic

  def self.denilize(h)
  h.each_with_object({}) { |(k,v),g|
    g[k] = (Hash === v) ?  denilize(v) : v.nil? ? 'N/a' : v }
  end

  def self.physicallink_summary
   xml = File.read("#{Rails.root}/public/netw_PhysicalLink.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)['Envelope']['Body']['findResponse']['result']['netw.PhysicalLink']
   return data_parsed
  end

  def self.physicalport_summary
   table_physicalport = Array.new []
   xml = File.read("#{Rails.root}/public/equipment_PhysicalPort.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)['Envelope']['Body']['findResponse']['result']['equipment.PhysicalPort']
   table_physicallink = physicallink_summary

   data_parsed.each do |device|
    descriptiona = device["description"]
    actualspeeda = device["actualSpeed"]
    devicea = device["siteName"]
    porta = device["displayedName"]
    deviceindexa = devicea + porta
    array_a = table_physicallink.select{|portid| device["objectFullName"] == portid["endpointAPointer"]}
    array_b = table_physicallink.select{|portid| device["objectFullName"] == portid["endpointBPointer"]}

    if (array_a != []) and (denilize(array_a[0])["endPointBSiteName"] != "N/a")
        @deviceb = denilize(array_a[0])["endPointBSiteName"]
    elsif (array_b != []) and (denilize(array_b[0])["endPointASiteName"] != "N/a")
        @deviceb = denilize(array_b[0])["endPointASiteName"]
    elsif (array_a != []) and (denilize(array_a[0])["endPointBSiteName"] = "N/a")
        @deviceb = denilize(array_a[0])["unmanagedEndpointB"]
    else
        @deviceb = "N/a"
    end
    #deviceindexb = @deviceb + @portb
    hash = Hash[device_a: devicea, port_a: porta, actualspeed_a: actualspeeda, description_a: descriptiona, deviceindex_a: deviceindexa, device_b: @deviceb]
    table_physicalport << hash
   end
   return table_physicalport
  end

  def self.interfacestats_summary
   xml = File.read("#{Rails.root}/public/InterfaceStats_Edge.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed['Envelope']['Body']['findResponse']['result']['equipment.InterfaceAdditionalStatsLogRecord']
  end

  def self.rateinterface_summary
   xml = File.read("#{Rails.root}/public/ethernetequipment_EthernetPortSpecifics.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed['Envelope']['Body']['findResponse']['result']['ethernetequipment.EthernetPortSpecifics']
  end

  def self.speed_nokia
   speednokia_array = CSV.read(Rails.root + "public/speed_nokia.csv")
  end

  def self.statsinterfacetotal_table
   tabletotal = Array.new []
   data_stats = interfacestats_summary

   data_stats.map do |qosdiscard_device|
    devicetotal = qosdiscard_device["monitoredObjectSiteName"]
    porttotal = qosdiscard_device["displayedName"]
    octetsrxtotal = qosdiscard_device["receivedTotalOctets"].to_i
    octetstxtotal = qosdiscard_device["transmittedTotalOctets"].to_i
    time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i/1000
     hash = Hash[devicetotal: devicetotal, porttotal: porttotal, octetsrxtotal: octetsrxtotal, octetstxtotal: octetstxtotal, device_int_stats_total: (devicetotal+porttotal).to_s, timeCapturedtotal: (Time.at(time_unixtotal).strftime("%b %e, %Y at %I:%M %p")), time_unixtotal: time_unixtotal]
     tabletotal << hash
   end
   return tabletotal.sort! { |a,b| b[:time_unixtotal] <=> a[:time_unixtotal] }
  end

  def self.statsinterfacesub_table
   groupedtotal  = statsinterfacetotal_table.group_by {|h| h[:device_int_stats_total]}
   
   keystotal = groupedtotal.keys

      arr_sub = keystotal.map { |k|
      [k, groupedtotal[k].each_cons(2).map do |g,h|
          { devicetotal: g[:devicetotal], porttotal: g[:porttotal], device_int_stats_total: g[:device_int_stats_total], octetsrxsub: g[:octetsrxtotal]-h[:octetsrxtotal], octetstxsub: g[:octetstxtotal]-h[:octetstxtotal], time_unixsub: g[:time_unixtotal]-h[:time_unixtotal], time_unixtotal: g[:time_unixtotal], timeCapturedtotal: g[:timeCapturedtotal]}
      end
      ]
      }

   
   table_sub = arr_sub.map { |ts| ts[1] }
   return table_sub.flatten.compact
  end


  def self.statsinterfacemax_table

   tablemax = Array.new []
   statsinterfacesub_table.map do |stats_device|
    nodesub = stats_device[:devicetotal]
    portsub = stats_device[:porttotal]
    time_unix = stats_device[:time_unixsub]
    timeCapturedsub = stats_device[:timeCapturedtotal]
    bwrxmax = (((stats_device[:octetsrxsub].to_f)*8/(time_unix*1000000))).round(2)
    bwtxmax = (((stats_device[:octetstxsub].to_f)*8/(time_unix*1000000))).round(2)
    device_int_stats = stats_device[:device_int_stats_total]
      if bwrxmax > bwtxmax
        bwmax = bwrxmax
      else
        bwmax = bwtxmax
      end
     hash = Hash[nodemax: nodesub, portmax: portsub, bwmax: bwmax, bwrxmax: bwrxmax, bwtxmax: bwtxmax, device_int_stats: device_int_stats, timeCapturedmax: timeCapturedsub]
     tablemax << hash
   end

   return tablemax.group_by{ |x| x[:device_int_stats] }.values.map{ |gp| gp.max_by{ |st| st[:bwmax] }}.sort! { |a,b| b[:bwmax] <=> a[:bwmax] }
  end

  def self.statsinterface_table
    table_stats = Array.new []
    data_rate = rateinterface_summary
    data_description = physicalport_summary

    statsinterfacemax_table.each do |stats_device|
      mbps_bwrx = stats_device[:bwrxmax].to_f
      mbps_bwtx = stats_device[:bwtxmax].to_f
      mbps_bw = stats_device[:bwmax].to_f
      port = stats_device[:portmax]
      device = stats_device[:nodemax]
      device_int_stats = (device+port).to_s

      data_description.select{|interface_description| device_int_stats == interface_description[:deviceindex_a]}.map{|interface_description|
        @description = interface_description[:description_a]
        @actualspeed2 = interface_description[:actualspeed_a]
        @deviceb = interface_description[:device_b]
      }

      data_rate.select{|interface_rate| device_int_stats == (interface_rate["siteName"] + interface_rate["displayedName"])}.map{|interface_rate|
        @portclass = interface_rate["portClass"]
        @egressrate = interface_rate["egressRate"]
      }

      speed_nokia.select{|speed_nokia| @portclass == speed_nokia[0]}.map{|speed_nokia|
        @speed = speed_nokia[2]
      }

      if @egressrate == "-1"
        @actualspeed = (@actualspeed2).to_i/1000
      else
        @actualspeed = (@egressrate).to_i/1000
      end

      if (Float(mbps_bw) != nil rescue false ) && (Float(@actualspeed) != nil rescue false)
          status = ((mbps_bw / @actualspeed) * 100.00 ).round(2)
      else
        status = 0.01
      end

      if @actualspeed != 0
        hash = Hash[node: device, mbps_bwrx: mbps_bwrx, mbps_bwtx: mbps_bwtx, status_total: status, 
          velodidad: @actualspeed, port_total: port, description_total: @description, speed_total: @speed, 
          mbps_bw: mbps_bw, deviceb: @deviceb, deviceport: device_int_stats]
        table_stats << hash
      end
    end
    return table_stats.sort! { |a,b| b[:status_total] <=> a[:status_total] }
  end

  def self.statsinterfacecrecimiento_table
   @tablecrecimiento_ipranedgeinterface = Array.new []
   table_device_all = ((IpranedgeInterface.pluck(:devicea, :name_devicea).compact.uniq) + (IpranedgeInterface.pluck(:deviceb, :name_deviceb).compact.uniq)).uniq.select {|e| e[1].present?}
   table_last_ipranedgeinterface = (IpranedgeInterface.where(IpranedgeInterface.arel_table[:created_at].gt(IpranedgeInterface.maximum(:created_at).to_date)))
   statsinterface_table.each do |statstotal|
    device = statstotal[:node]
    port = statstotal[:port_total]
    array_device_all_a = table_device_all.select{|deviceall| device == deviceall[0]}
    if array_device_all_a != []
      array_device_all_a.map{|deviceall|
        @name_devicea = deviceall[1]
    }
    else
      @name_devicea = nil
    end
    description = statstotal[:description_total]
    egressrate = statstotal[:velodidad]
    speed = statstotal[:speed_total]
    gbpsrx = statstotal[:mbps_bwrx]
    gbpstx = statstotal[:mbps_bwtx]
    deviceb = statstotal[:deviceb]
    array_device_all_b = table_device_all.select{|deviceall| deviceb == deviceall[0]}
    if array_device_all_b != []
      array_device_all_b.map{|deviceall|
        @name_deviceb = deviceall[1]
    }
    else
      @name_deviceb = nil
    end

    deviceindex = statstotal[:deviceport]
    if (statstotal[:status_total]).to_f > 100.00
      status = 100.00
      bps_max = egressrate
    else
      bps_max = statstotal[:mbps_bw]
      status = statstotal[:status_total]
    end
    array_last_iperanedgeinterface = table_last_ipranedgeinterface.select{|last_ipranedgeinterface| deviceindex == last_ipranedgeinterface[:deviceindex]}
    if array_last_iperanedgeinterface != []
      array_last_iperanedgeinterface.map{|last_ipranedgeinterface|
        @comment = last_ipranedgeinterface[:comment]
    }
    else
      @comment = "-"
    end
    if array_last_iperanedgeinterface != []
      array_last_iperanedgeinterface.map{|last_ipranedgeinterface|
        @time = last_ipranedgeinterface[:time]
    }
    else
      @time = "-"
    end
    if array_last_iperanedgeinterface != []
      array_last_iperanedgeinterface.map{|last_ipranedgeinterface|
        @provider_id = last_ipranedgeinterface[:provider_id]
    }
    else
      @provider_id = 4
    end
    if array_last_iperanedgeinterface != []
      array_last_iperanedgeinterface.map{|last_ipranedgeinterface|
        @last_status = last_ipranedgeinterface[:status]
        @last_bps_max = last_ipranedgeinterface[:bps_max]
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
    if (array_last_iperanedgeinterface != []) and (status > 84.99)
      array_last_iperanedgeinterface.map{|last_ipranedgeinterface|
        @weeks = last_ipranedgeinterface[:weeks] + 1
    }
    else
      @weeks = 0
    end
    hash = Hash[devicea: device, 
                porta: port, 
                descriptiona: description, 
                gbpsrx: gbpsrx, 
                gbpstx: gbpstx, 
                bps_max: bps_max, 
                last_bps_max: @last_bps_max, 
                last_status: @last_status, 
                crecimiento: @crecimiento, 
                status: status, 
                egressRate: egressrate, 
                speed: speed, 
                comment: @comment, 
                time: @time,  
                name_devicea: @name_devicea, 
                deviceb: deviceb, 
                name_deviceb: @name_deviceb, 
                deviceindex: deviceindex]
@tablecrecimiento_ipranedgeinterface << hash
   end
   return @tablecrecimiento_ipranedgeinterface.sort! { |a,b| b[:status] <=> a[:status] }
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
    if egressRate != 0
    	self.status = ((self.bps_max / self.egressRate)*100).round(2)
    	self.crecimiento = (((self.bps_max - self.last_bps_max)/self.last_bps_max)*100).round(2)
    else
    	self.status = 0
    	self.crecimiento = 0
    end
  end

end
