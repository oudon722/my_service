class ChangeLivedPrefectureToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :lived_prefecture, :integer
    add_column :users, :prefecture_id, :integer
  end
end
