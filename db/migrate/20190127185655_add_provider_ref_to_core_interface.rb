class AddProviderRefToCoreInterface < ActiveRecord::Migration[5.2]
  def change
    add_reference :core_interfaces, :provider, foreign_key: true, default: 4
  end
end
