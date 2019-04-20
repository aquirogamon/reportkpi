class CreateIpranaccessQosingressinterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :ipranaccess_qosingressinterfaces do |t|
      t.string :device
      t.string :sap
      t.integer :queueId
      t.float :bps_max
      t.float :discard
      t.float :discard_avg, default: 8
      t.date :time
      t.text :comment
      t.integer :weeks, default: 0
      t.string :device_sap
      t.string :device_sapqueue
      t.string :service
      t.references :tx_provider, foreign_key: true, default: 8

      t.timestamps
    end
  end
end
