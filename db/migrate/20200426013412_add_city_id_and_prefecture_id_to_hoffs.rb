class AddCityIdAndPrefectureIdToHoffs < ActiveRecord::Migration[5.1]
  def change
    add_column :hoffs, :prefecture_id, :integer
    add_column :hoffs, :city_id, :integer
  end
end
