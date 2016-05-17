class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :family, :string
    add_column :users, :name, :string
    add_column :users, :middlename, :string
    add_reference :users, :city, foreign_key: true
    add_column :users, :views, :integer
  end
end
