class CreateIpranedgeInterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :ipranedge_interfaces do |t|
      t.string :devicea
      t.string :porta
      t.string :descriptiona
      t.float :egressRate
      t.string :speed
      t.float :gbpsrx
      t.float :gbpstx
      t.float :last_bps_max
      t.float :last_status
      t.float :bps_max
      t.float :status
      t.float :crecimiento
      t.date :time
      t.text :comment
      t.integer :weeks, default: 0
      t.string :deviceindex
      t.string :name_devicea
      t.string :deviceb
      t.string :portb
      t.string :name_deviceb

      t.timestamps
    end
  end
end
