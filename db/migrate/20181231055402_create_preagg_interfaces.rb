class CreatePreaggInterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :preagg_interfaces do |t|
      t.string :device
      t.string :port
      t.string :servicio
      t.float :gbpsrx
      t.float :gbpstx
      t.float :bps_max
      t.float :status
      t.float :last_bps_max
      t.float :last_status
      t.float :crecimiento
      t.float :egressRate
      t.date :time
      t.text :comment
      t.integer :weeks, default: 0
      t.string :deviceindex

      t.timestamps
    end
  end
end
