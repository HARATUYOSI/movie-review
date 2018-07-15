class RenameMovieIdColumnToLikes < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :movie_id, :review_id
  end
end
