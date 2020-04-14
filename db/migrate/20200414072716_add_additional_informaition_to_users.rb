class AddAdditionalInformaitionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lived_area, :string
    add_column :users, :nearest_station, :string
    add_column :users, :ssbu_experience, :string
    add_column :users, :ssbu_skill, :string
    add_column :users, :using_character, :string
  end
end
