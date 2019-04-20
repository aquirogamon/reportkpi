class AddTitleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :title, :string
    add_index :users, :title
  end
end
