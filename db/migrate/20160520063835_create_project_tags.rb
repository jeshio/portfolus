class CreateProjectTags < ActiveRecord::Migration[5.0]
  def change
    create_table :project_tags do |t|
      t.references :tag, foreign_key: true, :on_delete => :cascade
      t.references :project, foreign_key: true, :on_delete => :cascade

    end
  end
end
