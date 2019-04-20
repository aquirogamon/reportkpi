class AddDiscardToManagerSessions < ActiveRecord::Migration[5.2]
  def change
  	add_column :manager_sessions, :discard, :float, default: 0
  end
end
