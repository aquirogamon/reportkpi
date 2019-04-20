class AddServiceToIpranaccessQosegressinterfaces < ActiveRecord::Migration[5.2]
  def change
  	add_column :ipranaccess_qosegressinterfaces, :service, :string
  end
end
