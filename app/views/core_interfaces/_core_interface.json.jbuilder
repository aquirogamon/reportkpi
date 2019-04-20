json.extract! core_interface, :id, :device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :weeks, :deviceindex, :location, :router, :created_at, :updated_at
json.url core_interface_url(core_interface, format: :json)
