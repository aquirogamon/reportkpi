# == Schema Information
#
# Table name: statusnokia_ports
#
#  id             :bigint(8)        not null, primary key
#  device         :string
#  port           :string
#  type_device    :string
#  configurespeed :string
#  speed          :string
#  description    :string
#  status         :string
#  service_all    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class StatusnokiaPort < ApplicationRecord

  def self.statusport_summary
   xml = File.read("#{Rails.root}/public/statusport.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed['Envelope']['Body']['findResponse']['result']['equipment.PhysicalPort']
  end

  def self.speed_nokia
    speednokia_array = CSV.read(Rails.root + "public/speed_nokia.csv")
  end

  def self.equipos_alu
    speednokia_array = CSV.read(Rails.root + "public/equipos_alu.csv")
  end

  def self.equipos_nokia_summary
   table_equipos_nokia = Array.new []
   table_equipos_alu = equipos_alu
   xml = File.read("#{Rails.root}/public/equipos_alu.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)['Envelope']['Body']['findResponse']['result']['netw.NetworkElement']
   data_parsed.each do |equiposnokia|
    siteName = equiposnokia["siteName"]
    descriptorVersion = equiposnokia["descriptorVersion"]
    chassisType = equiposnokia["chassisType"]
    location = equiposnokia["location"]
    version = equiposnokia["version"]
        array_equipos = table_equipos_alu.select{|equipos| chassisType == equipos[0]}
        if array_equipos != []
          array_equipos.map{|equipos|
            @chassisType_change = equipos[1]
        }
        else
          @chassisType_change = "-"
        end
    hash = Hash[siteName: siteName, descriptorVersion: descriptorVersion, location: location, version: version, chassisType_change: @chassisType_change]
    table_equipos_nokia << hash
   end
   return table_equipos_nokia
  end

  def self.interface_vprn_summary
  table_interfacevprn_nokia = Array.new []
  xml = File.read("#{Rails.root}/public/vprn_L3AccessInterface.xml")
  data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
  data_parsed = Hash.from_xml(data)["Envelope"]["Body"]["findResponse"]["result"]["vprn.L3AccessInterface"]
  data_parsed.each do |intefacevprn|
    name_device = intefacevprn["nodeName"]
    name_vprn = intefacevprn["serviceId"]
    service_type = intefacevprn["serviceType"]
    port_sap = intefacevprn["portIdentifyingName"]
    operational_state = intefacevprn["operationalState"]
    port_name = intefacevprn["portName"]
    port_description = intefacevprn["displayedName"]
    port_objectFullName = intefacevprn["objectFullName"]
    deviceport = name_device + port_name
    sap_object = port_objectFullName + port_description
    hash = Hash[name_device: name_device, name_vprn: name_vprn, service_type:service_type, port_sap: port_sap, operational_state: operational_state, 
                port_name: port_name, port_description: port_description, port_objectFullName: port_objectFullName, deviceport: deviceport, sap_object: sap_object]
    table_interfacevprn_nokia << hash
  end
  return table_interfacevprn_nokia
  end

  def self.samstatusport_table
   table = Array.new []
   StatusnokiaPort.delete_all
   data = statusport_summary
   table_equipos_all = equipos_nokia_summary
   table_service_port = interface_vprn_summary

   data.each do |device_routes|
    device = device_routes["siteName"]
    port = device_routes["displayedName"]
    actualSpeed_SAM = device_routes["actualSpeed"].to_i
    actualSpeed = actualSpeed_SAM/1000
    description = device_routes["description"]
    portClass = device_routes["portClass"]
    status = device_routes["administrativeState"]
    status_deviceport = device + port
      array_equipos_all = table_equipos_all.select{|equipos| device == equipos[:siteName]}
      if array_equipos_all != []
        array_equipos_all.map{|equipos|
          @tipo_equipo = equipos[:chassisType_change]
      }
      else
        @tipo_equipo = "-"
      end
      array_speed_nokia = speed_nokia.select{|speed_nokia| portClass == speed_nokia[0]}
      if array_speed_nokia != []
        array_speed_nokia.map{|speed_nokia|
          @speed = speed_nokia[2]
      }
      else
        @speed = "-"
      end
      array_service_port = table_service_port.select{|device_port| status_deviceport == device_port[:deviceport]}
      if array_service_port != []
        array_service_port.map{|concatenar_service|
          @service_all = array_service_port
      }
      else
        @service_all = "-"
      end
     hash = Hash[device: device, port: port, type_device: @tipo_equipo, configurespeed: actualSpeed, speed: @speed, description: description, status: status, service_all: @service_all]
     table << hash
   end
   return table.sort! { |a,b| b[:speed] <=> a[:speed] }
  end

  UNRANSACKABLE_ATTRIBUTES = ["id", "description", "created_at", "updated_at"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

end
