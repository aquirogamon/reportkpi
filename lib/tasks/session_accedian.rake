desc 'new session accedian manager'
task new_session_manager_accedian: :environment do
  # ... set options if any
  ManagerSession.create(ManagerSession.all_sessions_endpoint)
end
