class AddProviderRefToIpranedgeInterface < ActiveRecord::Migration[5.2]
  def change
    add_reference :ipranedge_interfaces, :provider, foreign_key: true, default: 4
  end
end
