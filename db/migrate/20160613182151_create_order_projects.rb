class CreateOrderProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :order_projects do |t|
      t.string :name
      t.text :description
      t.integer :price_min
      t.integer :price_max
      t.boolean :finished
      t.integer :views
      t.references :category, foreign_key: true, :null => true, :on_delete => :set_null

      t.timestamps
    end

    add_reference :order_projects, :customer, references: :users, index: true, :on_delete => :destroy
    add_foreign_key :order_projects, :users, column: :customer_id
    add_reference :order_projects, :executer, references: :users, index: true, :on_delete => :destroy
    add_foreign_key :order_projects, :users, column: :executer_id

    add_index :order_projects, :price_min
    add_index :order_projects, :price_max
    add_index :order_projects, :finished
  end
end
