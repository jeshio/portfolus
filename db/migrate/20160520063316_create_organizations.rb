class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.text :url
      t.string :reg_hash
      t.string :admin_email
      t.string :domen
      t.decimal :views
      t.timestamps
    end

    add_reference :organizations, :creater, references: :users, index: true, :null => true, :on_delete => :set_null
    add_foreign_key :organizations, :users, column: :creater_id
    add_index :organizations, :url, unique: true
    add_index :organizations, :reg_hash, unique: true
    add_index :organizations, :admin_email, unique: true
    add_index :organizations, :domen, unique: true
  end
end
