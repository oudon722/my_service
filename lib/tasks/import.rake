require 'csv'

# rake import:station_data
namespace :import do
  desc "Import station_data from csv"

  task station_data: :environment do
    path = File.join Rails.root, "db/csv/station_data.csv"
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
          station_g_cd: row["station_g_cd"],
          station_name: row["station_name"],
          line_cd: row["line_cd"],
          pref_cd: row["pref_cd"],
          address: row["address"],
          lon: row["lon"],
          lat: row["lat"]
      }
    end
    puts "start to create station data"
    begin
      StationDatum.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end
