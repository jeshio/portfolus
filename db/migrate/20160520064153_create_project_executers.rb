class CreateProjectExecuters < ActiveRecord::Migration[5.0]
  def change
    create_table :project_executers do |t|
      t.references :project, foreign_key: true, :on_delete => :cascade
      t.string :role
      t.datetime :start_date
      t.datetime :finish_date
      t.boolean :executer_confirmed, :default => false
      t.boolean :creater_confirmed, :default => false

      t.timestamps
    end

    add_reference :project_executers, :executer, references: :users, index: true, :null => true, :on_delete => :set_null
    add_foreign_key :project_executers, :users, column: :executer_id
  end
end
