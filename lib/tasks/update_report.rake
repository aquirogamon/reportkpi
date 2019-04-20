namespace :update_report do
	desc 'reload session accedian manager'
	task reload_session_accedian: :environment do
		puts "#{Time.now} - Reload Report"
		ManagerSession.reload_waiting_session
		ManagerSession.reload_error_session
		puts "#{Time.now} - Success!"
	end
end

namespace :update_report do
	desc 'restart session accedian manager'
	task restart_session_accedian: :environment do
		puts "#{Time.now} - Inicio - Restart Session"
		ManagerSession.name_session_all_restart
		puts "#{Time.now} - Fin Restart Session"
	end
end
