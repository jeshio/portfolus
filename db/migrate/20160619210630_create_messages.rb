class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.boolean :readed

      t.timestamps
    end

    add_reference :messages, :from, references: :users, index: true, :on_delete => :cascade
    add_foreign_key :messages, :users, column: :from_id
    add_reference :messages, :to, references: :users, index: true, :on_delete => :cascade
    add_foreign_key :messages, :users, column: :to_id
  end
end
