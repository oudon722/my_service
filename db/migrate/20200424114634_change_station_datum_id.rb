class ChangeStationDatumId < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :station_datum_id, :integer
    remove_column :hoffs, :station_datum_id, :integer
    add_column :users, :station_name, :string
    add_column :hoffs, :station_name, :string
  end
end
