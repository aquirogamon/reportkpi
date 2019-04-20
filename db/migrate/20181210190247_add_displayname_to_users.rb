class AddDisplaynameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :displayname, :string
    add_index :users, :displayname
  end
end
