require 'csv'

namespace :import do
	desc "Import internet_interface from CSV"

	task internet_interface: :environment do
		filename = File.join Rails.root, "interfaceinternet.csv"
		CSV.foreach(filename) do |row|
			device, port, servicio, egressRate, neighbor, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at, weeks = row
			InternetInterface.create(device: device, port: port, servicio: servicio, egressRate: egressRate, neighbor: neighbor, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at, weeks: weeks)
		end
	end
end

namespace :import do
	desc "Import core_interface from CSV"

	task core_interface: :environment do
		filename = File.join Rails.root, "interfacecore.csv"
		CSV.foreach(filename) do |row|
			device, port, servicio, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at, weeks, router, location = row
			CoreInterface.create(device: device, port: port, servicio: servicio, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at, weeks: weeks, router: router, location: location)
		end
	end
end

namespace :import do
	desc "Import ipranedge_interface from CSV"

	task ipranedge_interface: :environment do
		filename = File.join Rails.root, "ipranedgeinterface.csv"
		CSV.foreach(filename) do |row|
			devicea, porta, descriptiona, egressRate, speed, gbpsrx, gbpstx, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, created_at = row
			IpranedgeInterface.create(devicea: devicea, porta: porta, descriptiona: descriptiona, egressRate: egressRate, speed: speed, gbpsrx: gbpsrx, gbpstx: gbpstx, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import ipranaccess_interface from CSV"

	task ipranaccess_interface: :environment do
		filename = File.join Rails.root, "ipranaccessinterface.csv"
		CSV.foreach(filename) do |row|
			device, port, description, egressRate, speed, gbpsrx, gbpstx, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, created_at = row
			IpranaccessInterface.create(device: device, port: port, description: description, egressRate: egressRate, speed: speed, gbpsrx: gbpsrx, gbpstx: gbpstx, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import access internet from CSV"

	task access_internet: :environment do
		filename = File.join Rails.root, "accessinternet.csv"
		CSV.foreach(filename) do |row|
			hfc_cgn, hfc_public, hfc_ipv6, mobile_cgn, mobile_corporate, mobile_ipv6, mobile_olo, corporate, cache_in, created_at = row
			accessInternet.create(hfc_cgn: hfc_cgn, hfc_public: hfc_public, hfc_ipv6: hfc_ipv6, mobile_cgn: mobile_cgn, mobile_corporate: mobile_corporate, mobile_ipv6: mobile_ipv6, mobile_olo: mobile_olo, corporate: corporate, cache_in: cache_in, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cachegoogleinterface from CSV"

	task cachegoogleinterface: :environment do
		filename = File.join Rails.root, "cachegoogleinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CachegoogleInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cachefacebookinterface from CSV"

	task cachefacebookinterface: :environment do
		filename = File.join Rails.root, "cachefacebookinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CachefacebookInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cachenetflixinterface from CSV"

	task cachenetflixinterface: :environment do
		filename = File.join Rails.root, "cachenetflixinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CachenetflixInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import cacheakamaiinterface from CSV"

	task cacheakamaiinterface: :environment do
		filename = File.join Rails.root, "cacheakamaiinterface.csv"
		CSV.foreach(filename) do |row|
			nodo, device, port, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at = row
			CacheakamaiInterface.create(nodo: nodo, device: device, port: port, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at)
		end
	end
end

namespace :import do
	desc "Import preagg_interface from CSV"

	task preagg_interface: :environment do
		filename = File.join Rails.root, "interfacepreagg.csv"
		CSV.foreach(filename) do |row|
			device, port, servicio, egressRate, last_bps_max, last_status, bps_max, status, crecimiento, comment, time, deviceindex, gbpsrx, gbpstx, created_at, weeks = row
			PreaggInterface.create(device: device, port: port, servicio: servicio, egressRate: egressRate, last_bps_max: last_bps_max, last_status: last_status, bps_max: bps_max, status: status, crecimiento: crecimiento, comment: comment, time: time, deviceindex: deviceindex, gbpsrx: gbpsrx, gbpstx: gbpstx, created_at: created_at, weeks: weeks)
		end
	end
end

namespace :import do
	desc "Import internet_link from CSV"

	task internet_link: :environment do
		filename = File.join Rails.root, "internetlink.csv"
		CSV.foreach(filename) do |row|
			iru,tierone,location_usa,location_peru,device,port,lacp,id_iru,id_tierone,capacity,observation,time_activation,time_iru,time_rest,status, name_iru, name_tierone = row
			InternetLink.create(iru: iru, tierone: tierone, location_usa: location_usa, location_peru: location_peru, device: observation, port: port, lacp: lacp, id_iru: id_iru, id_tierone: id_tierone, capacity: capacity, observation: observation, time_activation: time_activation, time_iru: time_iru, time_rest: time_rest, status: status, name_iru: name_iru, name_tierone: name_tierone)
		end
	end
end

namespace :import do
	desc "Import manager_session from CSV"

	task manager_session: :environment do
		filename = File.join Rails.root, "manager_sessions.csv"
		CSV.foreach(filename) do |row|
			ip_endpoint,	name_endpoint,	product_endpoint,	state_endpoint,	type_endpoint,	capability,	port_endpoint,	tos_endpoint,	name_session,	sessionType,	sid,	dstEndpoint,	dstPort,	srcEndpoint,	srcIfc,	srcPort,	state_session,	interval_session,	tos_session,	payloadsize_session,	pps_session,	type_port,	sla,	status_device,	ip_interface_vcx,	dp50_p2r,	dpmax_p2r,	dpmin_p2r,	lossPercent_p2r,	dp50_r2p,	dpmax_r2p,	dpmin_r2p,	lossPercent_r2p,	delay_50,	delay_max,	delay_min,	created_at,	accediandevice_id,	lossPercent_p2r_p95,	lossPercent_r2p_p95,	delay_50_p95,	delay_max_p95,	tx_provider_id,	events_delay50,	events_lossp2r,	events_lossr2p = row
			ManagerSession.create(ip_endpoint:ip_endpoint,name_endpoint:name_endpoint,product_endpoint:product_endpoint,state_endpoint:state_endpoint,type_endpoint:type_endpoint,capability:capability,port_endpoint:port_endpoint,tos_endpoint:tos_endpoint,name_session:name_session,sessionType:sessionType,sid:sid,dstEndpoint:dstEndpoint,dstPort:dstPort,srcEndpoint:srcEndpoint,srcIfc:srcIfc,srcPort:srcPort,state_session:state_session,interval_session:interval_session,tos_session:tos_session,payloadsize_session:payloadsize_session,pps_session:pps_session,type_port:type_port,sla:sla,status_device:status_device,ip_interface_vcx:ip_interface_vcx,dp50_p2r:dp50_p2r,dpmax_p2r:dpmax_p2r,dpmin_p2r:dpmin_p2r,lossPercent_p2r:lossPercent_p2r,dp50_r2p:dp50_r2p,dpmax_r2p:dpmax_r2p,dpmin_r2p:dpmin_r2p,lossPercent_r2p:lossPercent_r2p,delay_50:delay_50,delay_max:delay_max,delay_min:delay_min,created_at:created_at,accediandevice_id:accediandevice_id,lossPercent_p2r_p95:lossPercent_p2r_p95,lossPercent_r2p_p95:lossPercent_r2p_p95,delay_50_p95:delay_50_p95,delay_max_p95:delay_max_p95,tx_provider_id:tx_provider_id, events_delay50:events_delay50,events_lossp2r:events_lossp2r,events_lossr2p:events_lossr2p)
		end
	end
end