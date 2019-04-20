set :output, { error: 'log/error.log', standard: 'log/cron.log' }
set :chronic_options, :hours24 => true

env :PATH, ENV['PATH']

every :monday, :at => '00:05' do
  rake 'new_report:new_report_ipranedge'
end

every :monday, :at => '00:05' do
  rake 'new_report:new_report_internet'
end

every :monday, :at => '00:30' do
  rake 'new_report:new_report_core'
end

every :monday, :at => '01:30' do
  rake 'new_report:new_report_preagg'
end

every :tuesday, :at => '00:00' do
  rake 'new_report:new_report_cac'
end

every 2.hours do
  rake 'new_report:new_session_manager_accedian'
end

every 2.hours do
  rake 'new_report:new_report_ipranacesoqosegress'
end

every 2.hours do
  rake 'new_report:new_report_ipranacesoqosingress'
end

every 2.hours do
  rake 'new_report:new_report_iprannetqosegress'
end

every 2.hours do
  rake 'new_report:new_report_iprannetqosingress'
end