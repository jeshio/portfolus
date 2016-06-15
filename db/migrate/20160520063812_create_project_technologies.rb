class CreateProjectTechnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :project_technologies do |t|
      t.references :technology, foreign_key: true, :on_delete => :cascade
      t.references :project, foreign_key: true, :on_delete => :cascade
      t.integer :power, limit: 2

    end
  end
end
