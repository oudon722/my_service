class AddEndDatesAndFirstLookToHoffs < ActiveRecord::Migration[5.1]
  def change
    add_column :hoffs, :end_dates, :datetime
    add_column :hoffs, :permit_first_look, :integer
  end
end
