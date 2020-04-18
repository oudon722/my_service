class CreateStationData < ActiveRecord::Migration[5.1]
  def change
    create_table :station_data do |t|
      t.integer :station_g_cd
      t.string :station_name
      t.integer :line_cd
      t.integer :pref_cd
      t.string :address
      t.integer :lon
      t.integer :lat

      t.timestamps
    end
  end
end
