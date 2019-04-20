class CreateInternetLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :internet_links do |t|
      t.string :iru
      t.string :tierone
      t.string :location_usa
      t.string :location_peru
      t.string :device
      t.string :port
      t.string :lacp
      t.string :id_iru
      t.string :id_tierone
      t.float :capacity
      t.string :observation
      t.date :time_activation
      t.integer :time_iru, default: 0
      t.date :time_rest
      t.string :status
      t.string :name_iru
      t.string :name_tierone

      t.timestamps
    end
  end
end
