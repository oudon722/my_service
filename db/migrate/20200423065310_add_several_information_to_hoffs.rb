class AddSeveralInformationToHoffs < ActiveRecord::Migration[5.1]
  def change
    add_column :hoffs, :required_level, :integer
    add_column :hoffs, :pt_cost, :integer
    add_column :hoffs, :max_pt_count, :integer
    add_column :hoffs, :parking_space, :integer
    add_column :hoffs, :station_datum_id, :integer
    add_column :hoffs, :details, :text
  end
end
