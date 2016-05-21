class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :country, null: true

      t.timestamps
    end

    add_foreign_key :cities, :countries, on_delete: :nullify
  end
end
