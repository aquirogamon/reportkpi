class AddTxproviderRefToIpranaccessQosegressinterface < ActiveRecord::Migration[5.2]
  def change
    add_reference :ipranaccess_qosegressinterfaces, :tx_provider, foreign_key: true, default: 8
  end
end
