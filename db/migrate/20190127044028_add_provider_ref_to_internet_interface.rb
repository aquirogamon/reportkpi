class AddProviderRefToInternetInterface < ActiveRecord::Migration[5.2]
  def change
    add_reference :internet_interfaces, :provider, foreign_key: true, default: 4
  end
end
