class CreateStatusnokiaPorts < ActiveRecord::Migration[5.2]
  def change
    create_table :statusnokia_ports do |t|
      t.string :device
      t.string :port
      t.string :type_device
      t.string :configurespeed
      t.string :speed
      t.string :description
      t.string :status
      t.string :service_all

      t.timestamps
    end
  end
end
