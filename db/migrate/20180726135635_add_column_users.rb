class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :delete_flag, :boolean, default: false, null: false

  end
end
