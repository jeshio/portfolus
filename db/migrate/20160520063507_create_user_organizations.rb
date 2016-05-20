class CreateUserOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_organizations do |t|
      t.references :user, foreign_key: true, :on_delete => :cascade
      t.references :organization, foreign_key: true, :on_delete => :cascade
      t.datetime :start_date
      t.datetime :finish_date
      t.string :status

      t.timestamps
    end
  end
end
