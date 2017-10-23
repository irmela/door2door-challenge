class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.datetime :time
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
