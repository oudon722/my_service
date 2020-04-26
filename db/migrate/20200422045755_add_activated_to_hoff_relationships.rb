class AddActivatedToHoffRelationships < ActiveRecord::Migration[5.1]
  def change
    add_column :hoff_relationships, :activated, :boolean, default: false
  end
end
