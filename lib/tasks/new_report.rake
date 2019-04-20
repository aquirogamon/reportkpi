namespace :new_report do
  desc "new session accedian manager"
  task new_session_manager_accedian: :environment do
    puts "#{Time.now} - Inicio - Restart Session"
    ManagerSession.name_session_all_restart
    puts "#{Time.now} - Fin Restart Session"
    sleep 360
  	puts "#{Time.now} - Updating the Session from Manager_Accedian"
  	ManagerSession.create(ManagerSession.all_sessions_endpoint)
  	puts "#{Time.now} — Success! Session from Manager_Accedian"
  end
end

namespace :new_report do
  desc "new report internet"
  task new_report_internet: :environment do
    puts "#{Time.now} - Updating new Report Internet"
  	InternetInterface.create(InternetInterface.statsinterfacecrecimiento_table)
    puts "#{Time.now} - Success! New Report Internet"
  end
end

namespace :new_report do
  desc "new report core"
  task new_report_core: :environment do
    puts "#{Time.now} - Updating new Report Core"
  	CoreInterface.create(CoreInterface.statsinterfacecrecimiento_table)
    puts "#{Time.now} - Success! New Report Core"
  end
end

namespace :new_report do
  desc "new report preagg"
  task new_report_preagg: :environment do
    puts "#{Time.now} - Updating new Report PreAGG"
  	PreaggInterface.create(PreaggInterface.statsinterfacecrecimiento_table)
    puts "#{Time.now} - Success! New Report PreAGG"
  end
end

namespace :new_report do
  desc "new report CPE CAC"
  task new_report_cac: :environment do
    puts "#{Time.now} - Updating new Report CPE_CAC"
    CpecacInterface.create(CpecacInterface.statsinterfacecrecimiento_table)
    puts "#{Time.now} - Success! New Report CPE_CAC"
  end
end

namespace :new_report do
  desc "new report ipran edge"
  task new_report_ipranedge: :environment do
    puts "#{Time.now} - Updating new Report IPRAN Edge"
    IpranedgeInterface.create(IpranedgeInterface.statsinterfacecrecimiento_table)
    puts "#{Time.now} - Success! New Report IPRAN Edge"
  end
end

namespace :new_report do
  desc "new report ipran qos egress"
  task new_report_ipranacesoqosegress: :environment do
    puts "#{Time.now} - Updating new Report IPRAN Acceso QoS Egress"
    start_time_egress = Time.now
    IpranaccessQosegressinterface.create(IpranaccessQosegressinterface.samqos7705egressdiscard_table)
    puts "#{Time.now} - Success! New Report IPRAN Acceso QoS Egress"
    #IpranaccessQosegressinterface.where(created_at: (IpranaccessQosegressinterface.maximum(:created_at) - 10.minutes)..IpranaccessQosegressinterface.maximum(:created_at)).update(created_at: start_time_egress)
  end
end

namespace :new_report do
  desc "new report ipran qos ingress"
  task new_report_ipranacesoqosingress: :environment do
    puts "#{Time.now} - Updating new Report IPRAN Acceso QoS Ingress"
    start_time_ingress = Time.now
    IpranaccessQosingressinterface.create(IpranaccessQosingressinterface.samqos7705ingressdiscard_table)
    puts "#{Time.now} - Success! New Report IPRAN Acceso QoS Ingress"
    #IpranaccessQosingressinterface.where(created_at: (IpranaccessQosingressinterface.maximum(:created_at) - 10.minutes)..IpranaccessQosingressinterface.maximum(:created_at)).update(created_at: start_time_ingress)
  end
end

namespace :new_report do
  desc "new report ipran qos net egress"
  task new_report_iprannetqosegress: :environment do
    puts "#{Time.now} - Updating new Report IPRAN Net QoS Egress"
    start_time_ingress = Time.now
    IprannetQosegressinterface.create(IprannetQosegressinterface.samqosnetegressdiscard_table)
    puts "#{Time.now} - Success! New Report IPRAN Net QoS Egress"
    #IpranaccessQosingressinterface.where(created_at: (IpranaccessQosingressinterface.maximum(:created_at) - 10.minutes)..IpranaccessQosingressinterface.maximum(:created_at)).update(created_at: start_time_ingress)
  end
end

namespace :new_report do
  desc "new report ipran qos net egress"
  task new_report_iprannetqosingress: :environment do
    puts "#{Time.now} - Updating new Report IPRAN Net QoS Ingress"
    start_time_ingress = Time.now
    IprannetQosingressinterface.create(IprannetQosingressinterface.samqosnetingressdiscard_table)
    puts "#{Time.now} - Success! New Report IPRAN Net QoS Ingress"
    #IpranaccessQosingressinterface.where(created_at: (IpranaccessQosingressinterface.maximum(:created_at) - 10.minutes)..IpranaccessQosingressinterface.maximum(:created_at)).update(created_at: start_time_ingress)
  end
end
