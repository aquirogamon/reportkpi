class CreateManagerSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :manager_sessions do |t|
      t.string :ip_endpoint
      t.string :name_endpoint
      t.string :product_endpoint
      t.string :state_endpoint
      t.string :type_endpoint
      t.string :capability
      t.string :port_endpoint
      t.string :tos_endpoint
      t.string :name_session
      t.string :sessionType
      t.float :sid
      t.string :dstEndpoint
      t.float :dstPort
      t.string :srcEndpoint
      t.string :srcIfc
      t.float :srcPort
      t.string :state_session
      t.float :interval_session
      t.float :tos_session
      t.float :payloadsize_session
      t.float :pps_session
      t.string :type_port
      t.string :sla
      t.string :status_device
      t.string :ip_interface_vcx
      t.float :dp50_p2r
      t.float :dpmax_p2r
      t.float :dpmin_p2r
      t.float :lossPercent_p2r
      t.float :dp50_r2p
      t.float :dpmax_r2p
      t.float :dpmin_r2p
      t.float :lossPercent_r2p
      t.float :delay_50
      t.float :delay_max
      t.float :delay_min
      t.float :lossPercent_p2r_p95
      t.float :lossPercent_r2p_p95
      t.float :delay_50_p95
      t.float :delay_max_p95
      t.integer :events_delay50, default: 0
      t.integer :events_lossp2r, default: 0
      t.integer :events_lossr2p, default: 0
      t.references :accediandevice, foreign_key: true
      t.references :tx_provider, foreign_key: true, default: 8

      t.timestamps
    end
  end
end
