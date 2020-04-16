class ChangeDataTitleToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :ssbu_experience, 'integer USING CAST(ssbu_experience AS integer)'
    change_column :users, :ssbu_skill, 'integer USING CAST(ssbu_skill AS integer)'
    change_column :users, :using_character, 'integer USING CAST(using_character AS integer)'
  end
end
