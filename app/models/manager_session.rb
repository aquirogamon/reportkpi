# == Schema Information
#
# Table name: manager_sessions
#
#  id                  :bigint(8)        not null, primary key
#  ip_endpoint         :string
#  name_endpoint       :string
#  product_endpoint    :string
#  state_endpoint      :string
#  type_endpoint       :string
#  capability          :string
#  port_endpoint       :string
#  tos_endpoint        :string
#  name_session        :string
#  sessionType         :string
#  sid                 :float
#  dstEndpoint         :string
#  dstPort             :float
#  srcEndpoint         :string
#  srcIfc              :string
#  srcPort             :float
#  state_session       :string
#  interval_session    :float
#  tos_session         :float
#  payloadsize_session :float
#  pps_session         :float
#  type_port           :string
#  sla                 :string
#  status_device       :string
#  ip_interface_vcx    :string
#  dp50_p2r            :float
#  dpmax_p2r           :float
#  dpmin_p2r           :float
#  lossPercent_p2r     :float
#  dp50_r2p            :float
#  dpmax_r2p           :float
#  dpmin_r2p           :float
#  lossPercent_r2p     :float
#  delay_50            :float
#  delay_max           :float
#  delay_min           :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  accediandevice_id   :bigint(8)
#

class ManagerSession < ApplicationRecord

  belongs_to :accediandevice
  belongs_to :tx_provider

  def self.percentile(values, percentile)
    if values.count > 1
    values_sorted = values.sort
    k = (percentile*(values_sorted.length-1)+1).floor - 1
    f = (percentile*(values_sorted.length-1)+1).modulo(1)
    return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
    else
    0
    end
  end

  def self.device_sam
   xml = File.read("#{Rails.root}/public/equipos_alu.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']
  end

  def self.all_vcxs
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed_vcx = Hash.from_xml(data)['endpointHeads']['EndpointHead'].select{|interfaces| interfaces["name"].include?("VCX")}.map{|vcx_name|
      name_all_vcx = vcx_name["name"]
    }
    return data_parsed_vcx
  end
  def self.id_vcx(id_vcx)
    endpoint = '/' + id_vcx
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/supervision" + endpoint
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed_interface = Hash.from_xml(data)['Endpoint']
    return data_parsed_interface
  end
  def self.detail_vcx
    table_all_vcx_detail = Array.new []
    table_all_vcx = all_vcxs

    table_all_vcx.each do |vcx_id|
      table_detail_vcx = id_vcx(vcx_id)
      if table_detail_vcx["Interfaces"] != nil
      name_vcx = table_detail_vcx["name"]
      gestion_vcx = table_detail_vcx["ip"]
      state_vcx = table_detail_vcx["state"]
      array_interface_vcx = table_detail_vcx["Interfaces"]["Interface"].select{|vcx_interface| vcx_interface["name"].include?("Traffic")}.map{|vcx_interface|
        interface_vcx = vcx_interface["name"]
        ip_interface_vcx = vcx_interface["IpAddresses"]["IpAddress"]["ip"]
        device_interface_vcx = name_vcx + interface_vcx
        hash = Hash[name_vcx: name_vcx, interface_vcx: interface_vcx, ip_interface_vcx: ip_interface_vcx, device_interface_vcx: device_interface_vcx]
        table_all_vcx_detail << hash
      }
      end
    end
    return table_all_vcx_detail
  end

  def self.all_devices(id_name_endpoint)
    table = Array.new []
    url_all_device = "http://172.19.216.78:8000/api/json/device/listDevices?apiKey=03765800ce85e7bbe4f0771bc391b323"
    data_all_device = RestClient::Request.execute(:url => url_all_device , :method => :get)
    data_parsed = JSON.load(data_all_device).select{|device_ip| device_ip["displayName"] == id_name_endpoint}.map{
      |device_ip| ip_address = device_ip["ipaddress"]
    }
    return data_parsed[0]
  end
  def self.status_devices(ip_name_endpoint)
    url_ip_device = "http://172.19.216.78:8000/api/json/device/getInterfaces?apiKey=03765800ce85e7bbe4f0771bc391b323&name=" + ip_name_endpoint
    data_status_device = RestClient::Request.execute(:url => url_ip_device , :method => :get)
    hash_device = {"message"=>"No Devices found."}
    if JSON.load(data_status_device) == hash_device
      data_parsed_device = "No Devices found."
    else
      data_parsed_device = JSON.load(data_status_device).select{|interfaces| interfaces["displayName"].include?("gestion")}.map{
        |interfaces| status_device = interfaces["statusStr"]
      }[0]
    end
    return data_parsed_device
  end

  # Exportamos todos los endpoint creados
  def self.all_endpoints
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['endpointHeads']['EndpointHead']
    return data_parsed
  end
  # Exportamos la configuración de un endpoint
  def self.id_endpoint(name_endpoint)
    endpoint = '/' + name_endpoint
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/reflector" + endpoint

    begin
      data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
    if (data != nil) and (data != "")
      data = Hash.from_xml(data)['Endpoint']
    else
      data = nil
    end
    return data
  end

  # Exportamos todos los session creados
  def self.all_sessions
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['sessionHeads']['SessionHead']
    return data_parsed
  end
  # Exportamos la configuración de un session
  def self.id_session(name_session)
    session = '/' + name_session
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/twamp#{session}"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['TwampSession']
    return data_parsed
  end

  # Exportamos todos los SLA creados
  def self.all_slas
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/sla"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    data_parsed = Hash.from_xml(data)['slas']['Sla']
    return data_parsed
  end
  # Exportamos las sesiones de cada SLA
  def self.id_sla(name_sla)
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/sla/" + name_sla + "/session"
    data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
    if Hash.from_xml(data)['sessionRefs'] != nil
      data_parsed = Hash.from_xml(data)['sessionRefs']["SessionRef"]
    end
    return data_parsed
  end
  def self.all_sessions_sla

    table_all_session_sla = Array.new []
    table_all_sla = all_slas

    table_all_sla.each do |allsla|
      name_sla_all = allsla["name"]
      table_sla_session = id_sla(name_sla_all)
      if table_sla_session != nil
      table_sla_session.map do |slasession|
        name_sla_session_all = slasession["name"]
        hash = Hash[name_sla_all: name_sla_all, name_sla_session_all: name_sla_session_all]
        table_all_session_sla << hash
      end
      end
    end
    return table_all_session_sla
  end

  def self.last_rr(id_session)
    table_last_rr = Array.new []
    base_url = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{id_session}/lastrr"
      begin
      data = RestClient::Request.execute(:url => base_url, :method => :get, :verify_ssl => false)
      rescue RestClient::ExceptionWithResponse => err
      err.response
      end
      if data != nil
        Hash.from_xml(data)["rRs"]["RR"].select{|direction| direction["direction"] == "p2r"}.map{|direction| 
        @dp50_p2r = ((direction["dp50"].to_f)/1000).round(2)
        @dpmax_p2r = (((direction["dpmax"]).to_f)/1000).round(2)
        @dpmin_p2r = (((direction["dpmin"]).to_f)/1000).round(2)
        @errcode_p2r = (direction["errcode"]).to_i
        @lossPercent_p2r = (direction["lossPercent"]).to_f
        }
        Hash.from_xml(data)["rRs"]["RR"].select{|direction| direction["direction"] == "r2p"}.map{|direction| 
        @dp50_r2p = ((direction["dp50"].to_f)/1000).round(2)
        @dpmax_r2p = (((direction["dpmax"]).to_f)/1000).round(2)
        @dpmin_r2p = (((direction["dpmin"]).to_f)/1000).round(2)
        @errcode_r2p = (direction["errcode"]).to_i
        @lossPercent_r2p = (direction["lossPercent"]).to_f
        }
        delay50 = (@dp50_p2r + @dp50_r2p).round(2)
        delaymax = (@dpmax_p2r + @dpmax_r2p).round(2)
        delaymin = (@dpmin_p2r + @dpmin_r2p).round(2)
        hash = Hash[dp50_p2r: @dp50_p2r, dpmax_p2r: @dpmax_p2r, dpmin_p2r: @dpmin_p2r, lossPercent_p2r: @lossPercent_p2r, dp50_r2p: @dp50_r2p, dpmax_r2p: @dpmax_r2p, dpmin_r2p: @dpmin_r2p, lossPercent_r2p: @lossPercent_r2p, delay50: delay50, delaymax: delaymax, delaymin: delaymin]
        table_last_rr << hash
      else
        table_last_rr = nil
      end
    return table_last_rr
  end

  def self.all_sessions_detail
    
    table_all_session_detail = Array.new []
    table_all_session = all_sessions
    table_all_endpoint = all_endpoints
    table_all_sla_session = all_sessions_sla
    table_all_status_device = device_sam
    table_accedian_device = Accediandevice.all.as_json

    table_all_session.map do |allsession|
      name_session = allsession["name"]
      sessionType = allsession["sessionType"]
      dstEndpoint = allsession["receiverNodeName"]
      srcEndpoint = allsession["senderNodeName"]
      state_session = allsession["state"]
      last_rr_session = last_rr(name_session)

        if last_rr_session != nil
          dp50_p2r = last_rr_session[0][:dp50_p2r]
          dpmax_p2r = last_rr_session[0][:dpmax_p2r]
          lossPercent_p2r = last_rr_session[0][:lossPercent_p2r]
          dp50_r2p = last_rr_session[0][:dp50_r2p]
          dpmax_r2p = last_rr_session[0][:dpmax_r2p]
          lossPercent_r2p = last_rr_session[0][:lossPercent_r2p]
          delay50 = last_rr_session[0][:delay50]
          delaymax = last_rr_session[0][:delaymax]
          delaymin = last_rr_session[0][:delaymin]
        else
          dp50_p2r = 0
          dpmax_p2r = 0
          lossPercent_p2r = 100.0
          dp50_r2p = 0
          dpmax_r2p = 0
          lossPercent_r2p = 100.0
          delay50 = 0
          delaymax = 0
          delaymin = 0
        end

      table_id_session = id_session(name_session)
      dstPort = table_id_session["dstPort"]
      srcPort = table_id_session["srcPort"]
      srcIfc = table_id_session["srcIfc"]
      state_session = table_id_session["state"]
      interval_session = table_id_session["interval"]
      tos_session = table_id_session["tos"]
      payloadsize_session = table_id_session["Stream"]["payloadsize"]
      pps_session = table_id_session["Stream"]["pps"]
      type_port = table_id_session["Stream"]["type"]

      table_all_endpoint.select{|allendpoint| dstEndpoint == allendpoint["name"]}.map{|allendpoint|
        name_endpoint = allendpoint["name"]
        ip_endpoint = allendpoint["ip"]
        product_endpoint = allendpoint["product"]
        type_endpoint = allendpoint["type"]
        state_endpoint = allendpoint["state"]

        table_all_id_endpoint = id_endpoint(name_endpoint)
        capability = table_all_id_endpoint["Capabilities"]["capability"]["cap"]
        if table_all_id_endpoint["TwampCp"] != nil
        port_endpoint = table_all_id_endpoint["TwampCp"]["port"]
        tos_endpoint = table_all_id_endpoint["TwampCp"]["tos"]
        else
        port_endpoint = "N/a"
        tos_endpoint = "N/a"
        end

        array_sla = table_all_sla_session.select{|idsla| name_session == idsla[:name_sla_session_all]}
        if array_sla != []
          array_sla.map{|idsla|
            @sla = idsla[:name_sla_all]
        }
        else
          @sla = "Sin_SLA"
        end

        array_status = table_all_status_device.select{|status| name_endpoint == status["displayedName"]}
        if array_status != []
          array_status.map{|status|
            @status_device = status["reachability"]
        }
        else
          @status_device = "Device Not Monitored"
        end

        table_accedian_device.select{|accediandevice| srcEndpoint == accediandevice["name_device"]}.map{|accediandevice|
          @accediandevice_id = accediandevice["id"]
        }

          hash = Hash[ip_endpoint: ip_endpoint, product_endpoint: product_endpoint, type_endpoint: type_endpoint, 
            state_endpoint: state_endpoint, name_session: name_session, sessionType: sessionType, 
            dstEndpoint: dstEndpoint, srcEndpoint: srcEndpoint, state_session: state_session, sla: @sla, 
            srcPort: srcPort, dstPort: dstPort, srcIfc: srcIfc, 
            interval_session: interval_session, tos_session: tos_session, 
            capability: capability, port_endpoint: port_endpoint, tos_endpoint: tos_endpoint, 
            payloadsize_session: payloadsize_session, pps_session: pps_session, type_port: type_port, status_device: @status_device, 
            accediandevice_id: @accediandevice_id, dp50_p2r: dp50_p2r, dpmax_p2r: dpmax_p2r, lossPercent_p2r: lossPercent_p2r, 
            dp50_r2p: dp50_r2p, dpmax_r2p: dpmax_r2p, lossPercent_r2p: lossPercent_r2p, delay_50: delay50, delay_max: delaymax, delay_min: delaymin]
          table_all_session_detail << hash
      }
    end

    return table_all_session_detail.sort_by { |a| [ a[:product_endpoint], a[:srcEndpoint], a[:state_session] ] }
  end

  def self.all_sessions_endpoint
    
    table_all_session_detail = Array.new []
    table_all_session_last = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 119.minutes)..ManagerSession.maximum(:created_at)).order("created_at ASC")
    table_all_session_lastday = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 360.minutes)..ManagerSession.maximum(:created_at))
    table_all_session = all_sessions
    table_all_endpoint = all_endpoints
    table_all_sla_session = all_sessions_sla
    table_all_status_device = device_sam
    table_accedian_device = Accediandevice.all.as_json

    table_all_session.each do |allsession|
      name_session = allsession["name"]
      sessionType = allsession["sessionType"]
      dstEndpoint = allsession["receiverNodeName"]
      srcEndpoint = allsession["senderNodeName"]
      state_session = allsession["state"]

      last_rr_session = last_rr(name_session)
        if last_rr_session != nil
          dp50_p2r = last_rr_session[0][:dp50_p2r]
          dpmax_p2r = last_rr_session[0][:dpmax_p2r]
          lossPercent_p2r = last_rr_session[0][:lossPercent_p2r]
          dp50_r2p = last_rr_session[0][:dp50_r2p]
          dpmax_r2p = last_rr_session[0][:dpmax_r2p]
          lossPercent_r2p = last_rr_session[0][:lossPercent_r2p]
          delay50 = last_rr_session[0][:delay50]
          delaymax = last_rr_session[0][:delaymax]
          delaymin = last_rr_session[0][:delaymin]
        else
          dp50_p2r = 0
          dpmax_p2r = 0
          lossPercent_p2r = 100.0
          dp50_r2p = 0
          dpmax_r2p = 0
          lossPercent_r2p = 100.0
          delay50 = 0
          delaymax = 0
          delaymin = 0
        end

      array_all_session_lastday = table_all_session_lastday.select{|percentile_value| percentile_value[:name_session] == name_session}
        array_lastday_lossp2r = ((array_all_session_lastday.pluck(:lossPercent_p2r)).push(lossPercent_p2r)).map {|e| e ? e : 0}.map {|e| e == 100 ? 0 : e}
        array_lastday_lossr2p = ((array_all_session_lastday.pluck(:lossPercent_r2p)).push(lossPercent_r2p)).map {|e| e ? e : 0}.map {|e| e == 100 ? 0 : e}
        array_lastday_delay50 = ((array_all_session_lastday.pluck(:delay_50)).push(delay50)).map {|e| e ? e : 0}
        array_lastday_delaymax = ((array_all_session_lastday.pluck(:delay_max)).push(delaymax)).map {|e| e ? e : 0}
        lossPercent_p2r_p95 = (percentile(array_lastday_lossp2r,0.95)).round(2)
        lossPercent_r2p_p95 = (percentile(array_lastday_lossr2p,0.95)).round(2)
        delay_50_p95 = (array_lastday_delay50.inject{ |sum, el| sum + el }.to_f / array_lastday_delay50.size).round(2)
        delay_max_p95 = (array_lastday_delaymax.inject{ |sum, el| sum + el }.to_f / array_lastday_delaymax.size).round(2)

      table_all_endpoint.select{|allendpoint| dstEndpoint == allendpoint["name"]}.map{|allendpoint|
        @name_endpoint = allendpoint["name"]
        @ip_endpoint = allendpoint["ip"]
        @product_endpoint = allendpoint["product"]
        @type_endpoint = allendpoint["type"]
        @state_endpoint = allendpoint["state"]
      }

      array_sla = table_all_sla_session.select{|idsla| name_session == idsla[:name_sla_session_all]}
      if array_sla != []
				array_sla.map{|idsla|
					@sla = idsla[:name_sla_all]
			}
			else
			  @sla = "Sin_SLA"
			end

      array_status = table_all_status_device.select{|status| @name_endpoint == status["displayedName"]}
      if array_status != []
        array_status.map{|status|
          @status_device = status["reachability"]
      }
      else
        @status_device = "Device Not Monitored"
      end

      array_all_session_last = table_all_session_last.select{|txprovider| name_session == txprovider[:name_session]}
      if array_all_session_last != []
        array_all_session_last.map{|txprovider|
          @tx_provider_id = txprovider[:tx_provider_id]
      }
      else
        @tx_provider_id = 8
      end

      table_accedian_device.select{|accediandevice| srcEndpoint == accediandevice["name_device"]}.map{|accediandevice|
        @accediandevice_id = accediandevice["id"]
      }

      if (array_all_session_last != []) and (lossPercent_p2r > 0) and (lossPercent_p2r < 100)
        array_all_session_last.map{|event|
          @events_lossp2r = event[:events_lossp2r] + 1
      }
      else
        @events_lossp2r = 0
      end

      if (array_all_session_last != []) and (lossPercent_r2p > 0) and (lossPercent_r2p < 100)
        array_all_session_last.map{|event|
          @events_lossr2p = event[:events_lossr2p] + 1
      }
      else
        @events_lossr2p = 0
      end

      if (array_all_session_last != []) and (delay_50_p95 > 7.99)
        array_all_session_last.map{|event|
          @events_delay50 = event[:events_delay50] + 1
      }
      else
        @events_delay50 = 0
      end

      if lossPercent_p2r_p95 > lossPercent_r2p_p95
        discard = lossPercent_p2r_p95
      else
        discard = lossPercent_r2p_p95
      end
        hash = Hash[ip_endpoint: @ip_endpoint, product_endpoint: @product_endpoint, type_endpoint: @type_endpoint, 
          state_endpoint: @state_endpoint, name_session: name_session, sessionType: sessionType, 
          dstEndpoint: dstEndpoint, srcEndpoint: srcEndpoint, state_session: state_session, sla: @sla, status_device: @status_device, 
          accediandevice_id: @accediandevice_id, dp50_p2r: dp50_p2r, dpmax_p2r: dpmax_p2r, lossPercent_p2r: lossPercent_p2r, 
          dp50_r2p: dp50_r2p, dpmax_r2p: dpmax_r2p, lossPercent_r2p: lossPercent_r2p, delay_50: delay50, delay_max: delaymax, delay_min: delaymin, 
          lossPercent_p2r_p95: lossPercent_p2r_p95, lossPercent_r2p_p95: lossPercent_r2p_p95, delay_50_p95: delay_50_p95, delay_max_p95: delay_max_p95, 
          events_delay50: @events_delay50, events_lossp2r: @events_lossp2r, events_lossr2p: @events_lossr2p, discard: discard, tx_provider_id: @tx_provider_id]
        table_all_session_detail << hash

    end

    #return table_all_session_detail.sort! { |a,b| b[:srcEndpoint] <=> a[:srcEndpoint] }
    return table_all_session_detail.sort_by { |a| [ a[:product_endpoint], a[:srcEndpoint], a[:state_session] ] }
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  private
  # Exportamos la configuración de un session
  def self.id_session_detail(id_params_session)
  	id_name_session = ManagerSession.find(id_params_session).name_session
    id_name_endpoint = ManagerSession.find(id_params_session).dstEndpoint

    table_id_session_detail = id_session(id_name_session)
    table_id_endpoint_detail = id_endpoint(id_name_endpoint)
    last_rr_session = last_rr(id_name_session)
    table_detail_vcx = detail_vcx

    dstPort = table_id_session_detail["dstPort"]
    srcPort = table_id_session_detail["srcPort"]
    srcIfc = table_id_session_detail["srcIfc"]
    state_session = table_id_session_detail["state"]
    interval_session = table_id_session_detail["interval"]
    tos_session = table_id_session_detail["tos"]
    payloadsize_session = table_id_session_detail["Stream"]["payloadsize"]
    pps_session = table_id_session_detail["Stream"]["pps"]
    type_port = table_id_session_detail["Stream"]["type"]

    srcEndpoint = table_id_session_detail["srcEndpoint"]
    srcIfc = table_id_session_detail["srcIfc"]
    device_interface = srcEndpoint + srcIfc

    ip_endpoint = table_id_endpoint_detail["ip"]
    state_endpoint = table_id_endpoint_detail["state"]
    capability = table_id_endpoint_detail["Capabilities"]["capability"]["cap"]
    if table_id_endpoint_detail["TwampCp"] != nil
    port_endpoint = table_id_endpoint_detail["TwampCp"]["port"]
    tos_endpoint = table_id_endpoint_detail["TwampCp"]["tos"]
    else
    port_endpoint = "N/a"
    tos_endpoint = "N/a"
    end

    if last_rr_session != nil
      dp50_p2r = last_rr_session[0][:dp50_p2r]
      dpmax_p2r = last_rr_session[0][:dpmax_p2r]
      lossPercent_p2r = last_rr_session[0][:lossPercent_p2r]
      dp50_r2p = last_rr_session[0][:dp50_r2p]
      dpmax_r2p = last_rr_session[0][:dpmax_r2p]
      lossPercent_r2p = last_rr_session[0][:lossPercent_r2p]
      delay50 = last_rr_session[0][:delay50]
      delaymax = last_rr_session[0][:delaymax]
      delaymin = last_rr_session[0][:delaymin]
    else
      dp50_p2r = 0
      dpmax_p2r = 0
      lossPercent_p2r = 100.0
      dp50_r2p = 0
      dpmax_r2p = 0
      lossPercent_r2p = 100.0
      delay50 = 0
      delaymax = 0
      delaymin = 0
    end

    table_detail_vcx.select{|interface_vcx| device_interface == interface_vcx[:device_interface_vcx]}.map{|interface_vcx| 
      @ip_interface_vcx = interface_vcx[:ip_interface_vcx]
    }

    array_sla = all_sessions_sla.select{|idsla| id_name_session == idsla[:name_sla_session_all]}
    if array_sla != []
      array_sla.map{|idsla|
        @sla = idsla[:name_sla_all]
    }
    else
      @sla = "Sin_SLA"
    end

    ManagerSession.find(id_params_session).update(dstPort: dstPort, srcPort: srcPort, srcIfc: srcIfc, state_session: state_session, 
    																			interval_session: interval_session, tos_session: tos_session, payloadsize_session: payloadsize_session,
    																			pps_session: pps_session, type_port: type_port, state_endpoint: state_endpoint, 
                                          capability: capability, port_endpoint: port_endpoint, tos_endpoint: tos_endpoint, sla: @sla,
                                          ip_endpoint: ip_endpoint, ip_interface_vcx: @ip_interface_vcx, dp50_p2r: dp50_p2r, dpmax_p2r: dpmax_p2r, lossPercent_p2r: lossPercent_p2r, 
                                          dp50_r2p: dp50_r2p, dpmax_r2p: dpmax_r2p, lossPercent_r2p: lossPercent_r2p, delay_50: delay50, delay_max: delaymax, delay_min: delaymin )

  end



  def self.restart_waiting_session

  table_name_session_waiting = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Waiting").pluck(:name_session)
  table_id_session_waiting = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Waiting").pluck(:id)

  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  table_name_session_waiting.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_stop.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_name_session_waiting.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_terminated.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_name_session_waiting.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_id_session_waiting.each do |id|
    id_session = id
    ManagerSession.id_session_detail(id_session)
  end
  end

  def self.restart_error_session

  table_name_session_error = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Error").pluck(:name_session)
  table_id_session_error = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Error").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  table_name_session_error.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_stop.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_name_session_error.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_terminated.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_name_session_error.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_id_session_error.each do |id|
    id_session = id
    ManagerSession.id_session_detail(id_session)
  end
  end

  def self.restart_terminated_session

  table_name_session_terminated = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Terminated").pluck(:name_session)
  table_id_session_terminated = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Terminated").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  sleep 10
  table_name_session_terminated.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_id_session_terminated.each do |id|
    id_session = id
    ManagerSession.id_session_detail(id_session)
  end
  end

  def self.start_session_terminated_router

  table_name_session_terminated = ManagerSession.where(state_session: "Terminated").where("name_session NOT LIKE ?", "%4G%").pluck(:name_session)
  table_id_session_terminated = ManagerSession.where(state_session: "Terminated").where("name_session NOT LIKE ?", "%4G%").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  sleep 10
  table_name_session_terminated.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_id_session_terminated.each do |id|
    id_session = id
    ManagerSession.id_session_detail(id_session)
  end
  end

  def self.start_session_terminated_4G

  table_name_session_terminated = ManagerSession.where(state_session: "Terminated").where("name_session LIKE ?", "%4G%").pluck(:name_session)
  table_id_session_terminated = ManagerSession.where(state_session: "Terminated").where("name_session LIKE ?", "%4G%").pluck(:id)


  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  sleep 10
  table_name_session_terminated.each do |session|
  name_session = session
  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/" + name_session + "/operate"
    RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end
  sleep 10
  table_id_session_terminated.each do |id|
    id_session = id
    ManagerSession.id_session_detail(id_session)
  end
  end


def self.reload_error_session

  table_id_session_error = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Error").pluck(:id)

  table_id_session_error.each do |id|
  id_session = id
  ManagerSession.id_session_detail(id_session)
  end

end

  def self.reload_waiting_session

    table_id_session_waiting = ManagerSession.where(created_at: (ManagerSession.maximum(:created_at) - 30.minutes)..ManagerSession.maximum(:created_at)).where(state_session: "Waiting").pluck(:id)

    table_id_session_waiting.each do |id|
    id_session = id
    ManagerSession.id_session_detail(id_session)
    end

  end

  def self.id_session_restart(id_params_session)
    name_session = ManagerSession.find(id_params_session).name_session
    url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{name_session}/operate"

    headers = {
    :content_type => "application/json"
    }
    data_action_stop = {
    "action":"stop"
    }
    data_action_terminated = {
    "action":"terminate"
    }
    data_action_start = {
    "action":"start"
    }
    RestClient::Request.execute(
      :url => url_session_action, 
      :method => :put, 
      :headers => headers,
      :payload => data_action_stop.to_json,
      :verify_ssl => false
    )
    sleep 2
    RestClient::Request.execute(
      :url => url_session_action, 
      :method => :put, 
      :headers => headers,
      :payload => data_action_terminated.to_json,
      :verify_ssl => false
    )
    sleep 2
    RestClient::Request.execute(
      :url => url_session_action, 
      :method => :put, 
      :headers => headers,
      :payload => data_action_start.to_json,
      :verify_ssl => false
    )
    sleep 5
    ManagerSession.id_session_detail(id_params_session)
  end

  def self.name_session_restart(name_session)
    url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{name_session}/operate"

    headers = {
    :content_type => "application/json"
    }
    data_action_stop = {
    "action":"stop"
    }
    data_action_terminated = {
    "action":"terminate"
    }
    data_action_start = {
    "action":"start"
    }
    RestClient::Request.execute(
      :url => url_session_action, 
      :method => :put, 
      :headers => headers,
      :payload => data_action_stop.to_json,
      :verify_ssl => false
    )
    sleep 2
    RestClient::Request.execute(
      :url => url_session_action, 
      :method => :put, 
      :headers => headers,
      :payload => data_action_terminated.to_json,
      :verify_ssl => false
    )
    sleep 2
    RestClient::Request.execute(
      :url => url_session_action, 
      :method => :put, 
      :headers => headers,
      :payload => data_action_start.to_json,
      :verify_ssl => false
    )
  end

  def self.terminated_name_session(name_session)

  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{name_session}/operate"

  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_stop.to_json,
    :verify_ssl => false
  )
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_terminated.to_json,
    :verify_ssl => false
  )
  end

  def self.start_name_session_terminated(name_session)

  url_session_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{name_session}/operate"

  headers = {
  :content_type => "application/json"
  }
  data_action_stop = {
  "action":"stop"
  }
  data_action_terminated = {
  "action":"terminate"
  }
  data_action_start = {
  "action":"start"
  }
  RestClient::Request.execute(
    :url => url_session_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_action_start.to_json,
    :verify_ssl => false
  )
  end

  def self.name_session_all_restart
    ManagerSession.all_sessions.select{|status| "Error" == status["state"]}.map{|status|
      name_session_error = status["name"]
      terminated_name_session(name_session_error)
    }
    sleep 10
    ManagerSession.all_sessions.select{|status| "Waiting" == status["state"]}.map{|status|
      name_session_waiting = status["name"]
      terminated_name_session(name_session_waiting)
    }
    sleep 10
    ManagerSession.all_sessions.select{|status| "Terminated" == status["state"]}.map{|status|
      name_session_terminated = status["name"]
      start_name_session_terminated(name_session_terminated)
    }
  end
def self.create_endpoint(name_equipo, ip_equipo, type_twamp)

  url_endpoint_create = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/reflector"
  url_endpoint_action = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/endpoint/#{name_equipo}/operate"

  headers = {
    :content_type => "application/json"
  }

  if type_twamp == "TWAMP Light"
    data_endpoint_create = {
      "ip"=>ip_equipo, "name"=>name_equipo, "product"=>"Router", "type"=>"Reflector", "Capabilities"=>{"capability"=>{"cap"=>"twamp-rf"}}
    }
  elsif type_twamp == "TWAMP Control"
    data_endpoint_create = {
      "ip"=>ip_equipo, "name"=>name_equipo, "product"=>"Router", "type"=>"Reflector", "Capabilities"=>{"capability"=>{"cap"=>"twamp-rf"}}, "TwampCp"=>{"address"=>ip_equipo, "legacyMode"=>"1", "tos"=>"184"}
    }
  end

  data_endpoint_action = {
    "action":"resolve"
  }

  RestClient::Request.execute(
    :url => url_endpoint_create, 
    :method => :post, 
    :headers => headers,
    :payload => data_endpoint_create.to_json,
    :verify_ssl => false
  )
  RestClient::Request.execute(
    :url => url_endpoint_action, 
    :method => :put, 
    :headers => headers,
    :payload => data_endpoint_action.to_json,
    :verify_ssl => false
  )
end

def self.devint
  CSV.read(Rails.root + "public/accedian.csv")[1..-1]
end

def self.create_session(name_equipo,actuador_site)

  devint.select{|localidad| localidad[2] == actuador_site}.map{|localidad| 
     @name_session_af12 = localidad[2] + "_" + name_equipo + "_AF12"
     @name_session_ef = localidad[2] + "_" + name_equipo + "_EF"
     @name_accedian = localidad[1]
     @name_sla_af12 = localidad[3] + "_AF12"
     @name_sla_ef = localidad[3] + "_EF"
  }
  url_session_create = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/twamp"
  url_session_action_af12 = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{@name_session_af12}/operate"
  url_session_action_ef = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/session/#{@name_session_ef}/operate"
  url_session_sla_af12 = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/sla/#{@name_sla_af12}/session"
  url_session_sla_ef = "https://C14593:Cl4r0peru51!@10.95.230.2/nbapi/sla/#{@name_sla_ef}/session"

  headers = {
    :content_type => "application/json"
  }
  data_create_session_af12 = {
    "addressFamily"=>"ipv4", "dstEndpoint"=>name_equipo, "dstIfc"=>"ext0", "dstPort"=>"4001", "interval"=>"60", "name"=>@name_session_af12, "srcEndpoint"=>@name_accedian, "srcIfc"=>"Traffic1", "srcPort"=>"14001", "tos"=>"48", "ttl"=>"255", "Stream"=>{"payloadsize"=>"82", "pps"=>"5.0", "type"=>"UDP"}
  }
  data_create_session_ef = {
    "addressFamily"=>"ipv4", "dstEndpoint"=>name_equipo, "dstIfc"=>"ext0", "dstPort"=>"4002", "interval"=>"60", "name"=>@name_session_ef, "srcEndpoint"=>@name_accedian, "srcIfc"=>"Traffic1", "srcPort"=>"14002", "tos"=>"184", "ttl"=>"255", "Stream"=>{"payloadsize"=>"82", "pps"=>"5.0", "type"=>"UDP"}
  }

  data_session_action = {
    "action":"start"
  }
  data_session_af12 = {
    "name":@name_session_af12
  }
  data_session_ef = {
    "name":@name_session_ef
  }

  RestClient::Request.execute(
    :url => url_session_create, 
    :method => :post, 
    :headers => headers,
    :payload => data_create_session_af12.to_json,
    :verify_ssl => false
  )
  RestClient::Request.execute(
    :url => url_session_create, 
    :method => :post, 
    :headers => headers,
    :payload => data_create_session_ef.to_json,
    :verify_ssl => false
  )

  RestClient::Request.execute(
    :url => url_session_action_af12, 
    :method => :put, 
    :headers => headers,
    :payload => data_session_action.to_json,
    :verify_ssl => false
  )
  RestClient::Request.execute(
    :url => url_session_action_ef, 
    :method => :put, 
    :headers => headers,
    :payload => data_session_action.to_json,
    :verify_ssl => false
  )

  sleep 5

  RestClient::Request.execute(
    :url => url_session_sla_af12, 
    :method => :put, 
    :headers => headers,
    :payload => data_session_af12.to_json,
    :verify_ssl => false
  )
  RestClient::Request.execute(
    :url => url_session_sla_ef, 
    :method => :put, 
    :headers => headers,
    :payload => data_session_ef.to_json,
    :verify_ssl => false
  )
end

def self.create_device
  CSV.read(Rails.root + "public/create_session.csv")
end


def self.new_session
create_device.each do |device|
  create_endpoint(device[0], device[1], device[3])
  create_session(device[0], device[2])
end
end

UNRANSACKABLE_ATTRIBUTES = ["id", "ip_endpoint", "name_endpoint", "capability", "sid", "srcIfc", "srcPort", "interval_session", "tos_session", 
                            "payloadsize_session", "pps_session", "type_port", "ip_interface_vcx", "created_at", "updated_at", "accediandevice_id",
                          		"dpmin_p2r", "dpmin_r2p"]

def self.ransackable_attributes auth_object = nil
  (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
end

end
