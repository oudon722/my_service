class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :details, :text, default: "よろしくお願いします。"
  end
end
