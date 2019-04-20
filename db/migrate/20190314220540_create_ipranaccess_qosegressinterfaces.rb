class CreateIpranaccessQosegressinterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :ipranaccess_qosegressinterfaces do |t|
      t.string :device
      t.string :sap
      t.integer :queueId
      t.float :bps_max
      t.float :discard
      t.float :discard_avg, default: 0
      t.date :time
      t.text :comment
      t.integer :weeks, default: 0
      t.string :device_sap
      t.string :device_sapqueue

      t.timestamps
    end
  end
end
