class IpranaccessQosegressinterface < ApplicationRecord

belongs_to :tx_provider

def self.qos7705egressdiscard_summary
xml_original = File.read("#{Rails.root}/public/service_SapEgrQosQueueStatsLogRecord_acceso.xml")
@updatexml = Nokogiri::XML::Document.parse(xml_original)
@updatexml.at_xpath('//*[name() = \'between\']').attributes["first"].value = (Time.now.to_time.to_i*1000  - 6600000).to_s
@updatexml.at_xpath('//*[name() = \'between\']').attributes["second"].value = (Time.now.to_time.to_i*1000).to_s
xml = @updatexml.to_xml
data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
data_parsed = Hash.from_xml(data)
return data_parsed['Envelope']['Body']['findResponse']['result']['service.SapEgrQosQueueStatsLogRecord']
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
object_sap = name_device + port_objectFullName + port_description
hash = Hash[name_device: name_device, name_service: name_vprn, object_sap: object_sap]
table_interfacevprn_nokia << hash
end
return table_interfacevprn_nokia
end

def self.interface_vpls_summary
table_interfacevpls_nokia = Array.new []
xml = File.read("#{Rails.root}/public/vpls_L2AccessInterface.xml")
data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
data_parsed = Hash.from_xml(data)["Envelope"]["Body"]["findResponse"]["result"]["vpls.L2AccessInterface"]
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
object_sap = name_device + port_objectFullName + port_description
hash = Hash[name_device: name_device, name_service: name_vprn, object_sap: object_sap]
table_interfacevpls_nokia << hash
end
return table_interfacevpls_nokia
end


def self.samqos7705egressdiscardtotal_table
tabletotal = Array.new []
data_stats = qos7705egressdiscard_summary
#table_service_port = interface_vprn_summary + interface_vpls_summary
data_stats.map do |qosdiscard_device|
devicetotal = qosdiscard_device["monitoredObjectSiteName"]
porttotal = qosdiscard_device["displayedName"]
queueIdtotal = qosdiscard_device["queueId"]
monitoredObjectPointertotal = qosdiscard_device["monitoredObjectPointer"]

#object_sap_total = devicetotal + monitoredObjectPointertotal + porttotal
#array_service_port = table_service_port.select{|objectfull| object_sap_total == objectfull[:object_sap]}
#if array_service_port != []
#array_service_port.map{|objectfull|
#  @servicetotal = objectfull[:name_service]
#}
#else
#@servicetotal = "-"
#end

discardinproftotal = qosdiscard_device["droppedInProfOctets"].to_i
discardoutproftotal = qosdiscard_device["droppedOutProfOctets"].to_i
forwardedinproftotal = qosdiscard_device["forwardedInProfOctets"].to_i
forwardedoutproftotal = qosdiscard_device["forwardedOutProfOctets"].to_i
time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i
hash = Hash[devicetotal: devicetotal, porttotal: porttotal, queueIdtotal: queueIdtotal, discardtotal: (discardinproftotal + discardoutproftotal), forwardedtotal: (forwardedinproftotal + forwardedoutproftotal), device_port_stats_total: (devicetotal+monitoredObjectPointertotal+porttotal).to_s, device_portqueue_stats_total: (devicetotal+monitoredObjectPointertotal+porttotal+queueIdtotal).to_s, timeCapturedtotal: (Time.at(time_unixtotal).strftime("%B %e, %Y at %I:%M %p")), time_unixtotal: time_unixtotal]
tabletotal << hash
end
return tabletotal.sort! { |a,b| b[:time_unixtotal] <=> a[:time_unixtotal] }
end

def self.samqos7705egressdiscardsub_table
groupedtotal  = samqos7705egressdiscardtotal_table.group_by {|h| h[:device_portqueue_stats_total]}

keystotal = groupedtotal.keys

arr_sub = keystotal.map { |k|
[k, groupedtotal[k].each_cons(2).map do |g,h|
{ devicetotal: g[:devicetotal], porttotal: g[:porttotal], queueIdtotal: g[:queueIdtotal], device_portqueue_stats_total: g[:device_portqueue_stats_total], device_port_stats_total: g[:device_port_stats_total], discard_sub: (g[:discardtotal]-h[:discardtotal]), forward_sub: (g[:forwardedtotal]-h[:forwardedtotal]), time_unix_sub: (g[:time_unixtotal]-h[:time_unixtotal]), time_unixtotal: g[:time_unixtotal], timeCapturedtotal: g[:timeCapturedtotal]}
end
]
}
table_sub = arr_sub.map { |ts| ts[1] }
return table_sub.flatten.compact
end

def self.samqos7705egressdiscard_table_last

table_ipranacceso_qosegress_last = Array.new []
samqos7705egressdiscardsub_table.each do |stats_device|
device = stats_device[:devicetotal]
port = stats_device[:porttotal]
queueId = stats_device[:queueIdtotal]
service = stats_device[:servicetotal]
periodicTime = stats_device[:time_unix_sub]
discard = (((stats_device[:discard_sub].to_f)*8/(periodicTime*1000))).round(2)
forward = (((stats_device[:forward_sub].to_f)*8/(periodicTime*1000))).round(2)
device_portqueue_stats = stats_device[:device_portqueue_stats_total]
device_port_stats = stats_device[:device_port_stats_total]
hash = Hash[device: device, sap: port, queueId: queueId, bps_max_last: forward, discard_last: discard, device_sap: device_port_stats, device_sapqueue: device_portqueue_stats]
table_ipranacceso_qosegress_last << hash
end
return table_ipranacceso_qosegress_last.group_by { |h| h[:device_sapqueue] }.map do |_,a|
    array_discard = a.map { |h| h[:discard_last] }
    imax = array_discard.each_index.max_by { |i| array_discard[i] }
    array_discar_avg = a.pluck(:discard_last)
    a[imax].merge(:bps_max=>(a.max_by{ |st| st[:bps_max_last] }[:bps_max_last]).round(2)).merge(:discard_avg_last=>((array_discar_avg.inject{ |sum, el| sum + el }.to_f / array_discar_avg.size).round(2)))
    end
end


def self.samqos7705egressdiscard_table
@table_ipranacceso_qosegress = Array.new []
time_start = Time.now
samqos7705egressdiscard_table_last.each do |stats_device|
device = stats_device[:device]
sap = stats_device[:sap]
queueId = stats_device[:queueId]
bps_max = stats_device[:bps_max]
discard = stats_device[:discard_last]
discard_avg = stats_device[:discard_avg_last]
service = stats_device[:service]
device_sap = stats_device[:device_sap]
device_sapqueue = stats_device[:device_sapqueue]
hash = Hash[device: device, sap: sap, queueId: queueId, bps_max: bps_max, discard: discard, discard_avg: discard_avg, device_sap: device_sap, device_sapqueue: device_sapqueue, created_at: time_start]
@table_ipranacceso_qosegress << hash
end
return @table_ipranacceso_qosegress.sort! { |a,b| b[:discard_avg] <=> a[:discard_avg] }
end


private

UNRANSACKABLE_ATTRIBUTES = ["id", "time", "comment", "device_sap", "device_sapqueue", "created_at", "updated_at"]

def self.ransackable_attributes auth_object = nil
  (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
end

end
