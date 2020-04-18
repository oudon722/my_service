class ChangeNearestStationIdToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :nearest_station_id, :integer
    add_column :users, :station_datum_id, :integer
  end
end
