class CreateAccediandevices < ActiveRecord::Migration[5.2]
  def change
    create_table :accediandevices do |t|
      t.string :site_name
      t.string :name_device
      t.string :type_device

      t.timestamps
    end
  end
end
