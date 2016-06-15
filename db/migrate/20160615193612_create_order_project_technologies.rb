class CreateOrderProjectTechnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :order_project_technologies do |t|
      t.references :order_project, foreign_key: true, :on_delete => :cascade
      t.references :technology, foreign_key: true, :on_delete => :cascade
    end
  end
end
