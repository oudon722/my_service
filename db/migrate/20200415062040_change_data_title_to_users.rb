class ChangeDataTitleToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :ssbu_experience, :integer
    change_column :users, :ssbu_skill, :integer
    change_column :users, :using_character, :integer
  end
end
