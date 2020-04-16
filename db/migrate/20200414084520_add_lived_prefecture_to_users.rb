class AddLivedPrefectureToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lived_prefecture, :integer
  end
end
