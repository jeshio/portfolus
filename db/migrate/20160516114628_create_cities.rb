class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :country, foreign_key: true, :null => true, :on_delete => :set_null

      t.timestamps
    end
  end
end
