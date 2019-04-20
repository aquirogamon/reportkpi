class CreateSevoneSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sevone_sessions do |t|
      t.string :session_name
      t.integer :session_id
      t.string :object_name
      t.integer :object_id
      t.string :device_name
      t.integer :device_id
      t.integer :device_elemets

      t.timestamps
    end
  end
end
