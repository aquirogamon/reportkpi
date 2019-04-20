desc 'reload session accedian manager'
task reload_session_accedian: :environment do
  # ... set options if any
  ManagerSession.reload_waiting_session
  ManagerSession.reload_error_session
end
