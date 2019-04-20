json.extract! preagg_interface, :id, :device, :port, :servicio, :gbpsrx, :gbpstx, :bps_max, :status, :last_bps_max, :last_status, :crecimiento, :egressRate, :time, :comment, :weeks, :deviceindex, :created_at, :updated_at
json.url preagg_interface_url(preagg_interface, format: :json)
