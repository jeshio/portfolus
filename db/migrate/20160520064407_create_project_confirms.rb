class CreateProjectConfirms < ActiveRecord::Migration[5.0]
  def change
    create_table :project_confirms do |t|
      t.references :project_executer, foreign_key: true, :on_delete => :cascade
      t.string :comment

      t.timestamps
    end

    add_reference :project_confirms, :confirmer, references: :users, index: true, :null => true, :on_delete => :set_null
    add_foreign_key :project_confirms, :users, column: :confirmer_id
  end
end
