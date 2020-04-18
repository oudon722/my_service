class RemoveNearestStationFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :nearest_station, :string
  end
end
