class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :custom_name
      t.string :mapped_address
      t.string :place_type
      t.decimal :latitude, {:precision=>10, :scale=>6}
      t.decimal :longitude, {:precision=>10, :scale=>6}
      t.boolean :visited
      t.string :description

      t.timestamps
    end
  end
end
