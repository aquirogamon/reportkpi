  def self.physicalport_summary
   xml = File.read("#{Rails.root}/public/equipment_PhysicalPort.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)['Envelope']['Body']['findResponse']['result']['equipment.PhysicalPort']
   return data_parsed
  end

  def self.physicallink_summary
   table_physicallink = Array.new []
   xml = File.read("#{Rails.root}/public/netw_PhysicalLink.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)['Envelope']['Body']['findResponse']['result']['netw.PhysicalLink']
   table_physicalport = physicalport_summary
   data_parsed.each do |device|
    endPointASiteName = device["endPointASiteName"]
    table_physicalport.select{|portid| device["endpointAPointer"] == portid["objectFullName"]}.map{|portid|
          @portA = portid["displayedName"]
          @descriptionA = portid["description"]
          @actualSpeedA = portid["actualSpeed"]
    }
    deviceindexA = endPointASiteName + @portA
    if device["endPointBSiteName"] != "N/A"
    endPointBSiteName = device["endPointBSiteName"]
    table_physicalport.select{|portid| device["endpointBPointer"] == portid["objectFullName"]}.map{|portid|
          @portB = portid["displayedName"]
    }
    else
    endPointBSiteName = device["unmanagedEndpointB"]
          @portB = "-"
    end
    hash = Hash[DeviceNameA: endPointASiteName, portA: @portA, deviceindexA: deviceindexA, DeviceNameB: endPointBSiteName, portB: @portB, descriptionA: @descriptionA, actualSpeed: @actualSpeedA]
    table_physicallink << hash
   end
   return table_physicallink
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
       hash = Hash[devicetotal: devicetotal, porttotal: porttotal, octetsrxtotal: octetsrxtotal, octetstxtotal: octetstxtotal, device_int_stats_total: (devicetotal+porttotal).to_s, timeCapturedtotal: (Time.at(time_unixtotal).strftime("%B %e, %Y at %I:%M %p")), time_unixtotal: time_unixtotal]
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

     tablemax.group_by{ |x| x[:device_int_stats] }.values.map{ |gp| gp.max_by{ |st| st[:bwmax] }}
    end

    def self.statsinterface_table
      table_stats = Array.new []
      data_rate = rateinterface_summary
      data_description = physicallink_summary

      statsinterfacemax_table.map do |stats_device|
        mbps_bwrx = stats_device[:bwrxmax].to_f
        mbps_bwtx = stats_device[:bwtxmax].to_f
        mbps_bw = stats_device[:bwmax].to_f
        timeCaptured = stats_device[:timeCapturedmax]
        port = stats_device[:portmax]
        device = stats_device[:nodemax]
        device_int_stats = (device+port).to_s

        data_description.select{|interface_description| device_int_stats == interface_description[:deviceindexA]}.map{|interface_description|
          @description = interface_description[:descriptionA]
          @actualSpeed2 = interface_description[:actualSpeed]
          @deviceB = interface_description[:DeviceNameB]
          @portB = interface_description[:portB]
        }

        data_rate.select{|interface_rate| device_int_stats == (interface_rate["siteName"] + interface_rate["displayedName"])}.map{|interface_rate|
          @portClass = interface_rate["portClass"]
          @egressRate = interface_rate["egressRate"]
        }

        speed_nokia.select{|speed_nokia| @portClass == speed_nokia[0]}.map{|speed_nokia|
          @speed = speed_nokia[2]
        }

        if @egressRate == "-1"
          @actualSpeed = (@actualSpeed2).to_i/1000
        else
          @actualSpeed = (@egressRate).to_i/1000
        end

        if (Float(mbps_bw) != nil rescue false ) && (Float(@actualSpeed) != nil rescue false)

            status = ((mbps_bw / @actualSpeed) * 100.00 ).round(2)
        else
          status = 0.00
        end

        unless mbps_bw == 0
          hash = Hash[node: device, mbps_bwrx: mbps_bwrx, mbps_bwtx: mbps_bwtx, status_total: status, 
            velodidad: @actualSpeed, port_total: port, description_total: @description, speed_total: @speed, 
            mbps_bw: mbps_bw, deviceB: @deviceB, portB: @portB, deviceport: device_int_stats]
          table_stats << hash
        end
      end
      return table_stats.sort! { |a,b| b[:status_total] <=> a[:status_total] }
    end

statsinterface_table
