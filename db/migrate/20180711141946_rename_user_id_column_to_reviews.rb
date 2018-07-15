class RenameUserIdColumnToReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :User_id, :user_id
  end
end
