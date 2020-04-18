class AddLonAndLatToStationData < ActiveRecord::Migration[5.1]
  def change
    add_column :station_data, :lon, :decimal
    add_column :station_data, :lat, :decimal
  end
end
