class IprannetQosegressinterface < ApplicationRecord
belongs_to :tx_provider

def self.qosnetegressdiscard_summary
xml_original = File.read("#{Rails.root}/public/equipment_PortNetEgressStatsLogRecord.xml")
@updatexml = Nokogiri::XML::Document.parse(xml_original)
@updatexml.at_xpath('//*[name() = \'between\']').attributes["first"].value = (Time.now.to_time.to_i*1000  - 6600000).to_s
@updatexml.at_xpath('//*[name() = \'between\']').attributes["second"].value = (Time.now.to_time.to_i*1000).to_s
xml = @updatexml.to_xml
data = RestClient.post("http://10.140.255.1:8080/xmlapi/invoke", xml,{:"Content-Type" => 'application/soap+xml'})
data_parsed = Hash.from_xml(data)
return data_parsed['Envelope']['Body']['findResponse']['result']['equipment.PortNetEgressStatsLogRecord']
end


def self.samqosnetegressdiscardtotal_table
tabletotal = Array.new []
data_stats = qosnetegressdiscard_summary
data_stats.map do |qosdiscard_device|
devicetotal = qosdiscard_device["monitoredObjectSiteName"]
porttotal = qosdiscard_device["displayedName"]
queueIdtotal = qosdiscard_device["queueId"]
monitoredObjectPointertotal = qosdiscard_device["monitoredObjectPointer"]
discardinproftotal = qosdiscard_device["inProfileOctetsDropped"].to_i
discardoutproftotal = qosdiscard_device["outOfProfileOctetsDropped"].to_i
forwardedinproftotal = qosdiscard_device["inProfileOctetsForwarded"].to_i
forwardedoutproftotal = qosdiscard_device["outOfProfileOctetsForwarded"].to_i
time_unixtotal = (qosdiscard_device["timeCaptured"]).to_i
hash = Hash[devicetotal: devicetotal, porttotal: porttotal, queueIdtotal: queueIdtotal, 
discardtotal: (discardinproftotal + discardoutproftotal), forwardedtotal: (forwardedinproftotal + forwardedoutproftotal), 
device_port_stats_total: (devicetotal+porttotal).to_s, 
device_portqueue_stats_total: (devicetotal+porttotal+queueIdtotal).to_s, time_unixtotal: time_unixtotal]
tabletotal << hash
end
return tabletotal.sort! { |a,b| b[:time_unixtotal] <=> a[:time_unixtotal] }
end

def self.samqosnetegressdiscardsub_table
groupedtotal  = samqosnetegressdiscardtotal_table.group_by {|h| h[:device_portqueue_stats_total]}

keystotal = groupedtotal.keys

arr_sub = keystotal.map { |k|
[k, groupedtotal[k].each_cons(2).map do |g,h|
{ devicetotal: g[:devicetotal], porttotal: g[:porttotal], queueIdtotal: g[:queueIdtotal], device_portqueue_stats_total: g[:device_portqueue_stats_total], device_port_stats_total: g[:device_port_stats_total], discard_sub: (g[:discardtotal]-h[:discardtotal]), forward_sub: (g[:forwardedtotal]-h[:forwardedtotal]), time_unix_sub: (g[:time_unixtotal]-h[:time_unixtotal]), time_unixtotal: g[:time_unixtotal]}
end
]
}
table_sub = arr_sub.map { |ts| ts[1] }
return table_sub.flatten.compact
end

def self.samqosnetegressdiscard_table_last

table_iprannet_qosegress_last = Array.new []
samqosnetegressdiscardsub_table.each do |stats_device_last|
device = stats_device_last[:devicetotal]
port = stats_device_last[:porttotal]
queueId = stats_device_last[:queueIdtotal]
service = stats_device_last[:servicetotal]
periodicTime = stats_device_last[:time_unix_sub]
discard = (((stats_device_last[:discard_sub].to_f)*8/(periodicTime*1000))).round(2)
forward = (((stats_device_last[:forward_sub].to_f)*8/(periodicTime*1000))).round(2)
device_portqueue_stats = stats_device_last[:device_portqueue_stats_total]
device_port_stats = stats_device_last[:device_port_stats_total]
hash = Hash[device_last: device, port_last: port, queueId_last: queueId, bps_max_last: forward, discard_last: discard, device_port_last: device_port_stats, device_portqueue_last: device_portqueue_stats]
table_iprannet_qosegress_last << hash
end
return table_iprannet_qosegress_last.group_by { |h| h[:device_portqueue_last] }.map do |_,a|
array_discard = a.map { |h| h[:discard_last] }
imax = array_discard.each_index.max_by { |i| array_discard[i] }
array_discar_avg = a.pluck(:discard_last)
a[imax].merge(:bps_max=>(a.max_by{ |st| st[:bps_max_last] }[:bps_max_last]).round(2)).merge(:discard_avg_last=>((array_discar_avg.inject{ |sum, el| sum + el }.to_f / array_discar_avg.size).round(2)))
end
end


def self.samqosnetegressdiscard_table
@table_iprannet_qosegress = Array.new []
time_start = Time.now
samqosnetegressdiscard_table_last.each do |stats_device|
device = stats_device[:device_last]
port = stats_device[:port_last]
queueId = stats_device[:queueId_last]
bps_max = stats_device[:bps_max]
discard = stats_device[:discard_last]
discard_avg = stats_device[:discard_avg_last]
device_port = stats_device[:device_port_last]
device_portqueue = stats_device[:device_portqueue_last]
hash = Hash[device: device, port: port, queueId: queueId, bps_max: bps_max, discard: discard, discard_avg: discard_avg, device_port: device_port, device_portqueue: device_portqueue, created_at: time_start]
@table_iprannet_qosegress << hash
end
return @table_iprannet_qosegress.sort! { |a,b| b[:bps_max] <=> a[:bps_max] }
end


private

UNRANSACKABLE_ATTRIBUTES = ["id", "time", "comment", "device_port", "device_portqueue", "created_at", "updated_at"]

def self.ransackable_attributes auth_object = nil
  (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
end

end
