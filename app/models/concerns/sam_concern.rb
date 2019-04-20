module	SamConcern
	extend ActiveSupport::Concern

	def interface_vprn_summary
		xml = File.read("#{Rails.root}/public/vprn_L3AccessInterface.xml")
		data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
		data_parsed = Hash.from_xml(data)
		return data_parsed["Envelope"]["Body"]["findResponse"]["result"]["vprn.L3AccessInterface"]
	end

  def self.statusport_summary
   xml = File.read("#{Rails.root}/public/equipment_PhysicalPort.xml")
   data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
   data_parsed = Hash.from_xml(data)
   return data_parsed['Envelope']['Body']['findResponse']['result']['equipment.PhysicalPort']
  end

  def speed_nokia
    speednokia_array = CSV.read(Rails.root + "public/speed_nokia.csv")
  end

  def equipos_alu
    speednokia_array = CSV.read(Rails.root + "public/equipos_alu.csv")
  end

  def equipos_nokia_summary
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

end