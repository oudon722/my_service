class RemoveLivedAreaFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :lived_area, :string
  end
end
