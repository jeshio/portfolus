class CreateOrderExecuterRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :order_executer_requests do |t|
      t.references :order_project, foreign_key: true, :on_delete => :cascade
      t.string :comment
      t.boolean :by_customer
      t.boolean :confirmed

      t.timestamps
    end

    add_reference :order_executer_requests, :executer, references: :users, index: true, :on_delete => :cascade
    add_foreign_key :order_executer_requests, :users, column: :executer_id
  end
end
