class CreateIpranedgeInterfaceSaves < ActiveRecord::Migration[5.2]
  def change
    create_table :ipranedge_interface_saves do |t|
      t.string :receivedTotalOctets
      t.string :transmittedTotalOctets
      t.string :timeCaptured
      t.string :periodicTime
      t.string :displayedName
      t.string :monitoredObjectSiteName

      t.timestamps
    end
  end
end
