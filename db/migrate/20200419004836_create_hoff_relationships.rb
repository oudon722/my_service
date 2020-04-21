class CreateHoffRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :hoff_relationships do |t|
      t.integer :hoff_id
      t.integer :participant_id

      t.timestamps
    end
    add_index :hoff_relationships, :hoff_id
    add_index :hoff_relationships, :participant_id
    add_index :hoff_relationships, [:hoff_id, :participant_id], unique: true
  end
end
