class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :dev_finish_date
      t.datetime :finish_date
      t.decimal :views
      t.string :version
      t.references :category, foreign_key: true, :null => true, :on_delete => :set_null
      t.references :organization, foreign_key: true, :null => true, :on_delete => :set_null

      t.timestamps
    end

    add_reference :projects, :client, references: :users, index: true, :null => true, :on_delete => :set_null
    add_foreign_key :projects, :users, column: :client_id
    add_reference :projects, :creater, references: :users, index: true, :null => true, :on_delete => :set_null
    add_foreign_key :projects, :users, column: :creater_id
  end
end
