class CreateIprannetQosegressinterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :iprannet_qosegressinterfaces do |t|
      t.string :device
      t.string :port
      t.integer :queueId
      t.float :bps_max
      t.float :discard
      t.float :discard_avg
      t.date :time
      t.text :comment, default: "-"
      t.integer :weeks, default: 0
      t.string :device_port
      t.string :device_portqueue
      t.string :service, default: "-"
      t.references :tx_provider, foreign_key: true, default: 8

      t.timestamps
    end
  end
end
