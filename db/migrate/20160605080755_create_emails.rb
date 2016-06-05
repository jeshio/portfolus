class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :email
      t.string :confirm_hash
      t.boolean :confirmed, :default => false

      t.timestamps
    end
    add_reference :emails, :user, references: :users, index: true, unique: true, :on_delete => :cascade
    add_foreign_key :emails, :users, column: :user_id
    add_index :emails, :email, unique: true
    add_index :emails, :confirm_hash, unique: true
  end
end
