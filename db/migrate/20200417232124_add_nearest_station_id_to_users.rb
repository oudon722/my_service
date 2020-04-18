class AddNearestStationIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nearest_station_id, :integer
  end
end
