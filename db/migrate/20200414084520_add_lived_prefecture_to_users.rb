class AddLivedPrefectureToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lived_prefecture, 'integer USING CAST(lived_prefecture AS integer)'
  end
end
