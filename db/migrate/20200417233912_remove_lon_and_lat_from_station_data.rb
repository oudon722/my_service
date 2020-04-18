class RemoveLonAndLatFromStationData < ActiveRecord::Migration[5.1]
  def change
    remove_column :station_data, :lon
    remove_column :station_data, :lat
  end
end
