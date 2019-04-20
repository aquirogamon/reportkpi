desc 'restart session accedian manager'
task restart_session_accedian: :environment do
  # ... set options if any
  ManagerSession.name_session_all_restart
  ManagerSession.restart_error_session
end
