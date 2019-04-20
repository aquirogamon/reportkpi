class CreateDeviceProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :device_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
