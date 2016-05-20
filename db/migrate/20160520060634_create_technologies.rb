class CreateTechnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :technologies do |t|
      t.string :name

      t.timestamps
    end
    add_index :technologies, :name, unique: true
  end
end
