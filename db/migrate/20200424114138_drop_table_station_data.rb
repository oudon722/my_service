class DropTableStationData < ActiveRecord::Migration[5.1]
  def change
    drop_table :station_data
  end
end
