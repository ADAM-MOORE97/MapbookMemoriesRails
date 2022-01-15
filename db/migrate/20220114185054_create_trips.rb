class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.date :start_data
      t.date :end_date
      t.boolean :taken
      t.string :description

      t.timestamps
    end
  end
end
