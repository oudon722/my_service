class CreateHoffs < ActiveRecord::Migration[5.1]
  def change
    create_table :hoffs do |t|
      t.string :name
      t.datetime :dates
      t.integer :owner_id

      t.timestamps
    end
    add_index :hoffs, :name
    add_index :hoffs, :owner_id
  end
end
