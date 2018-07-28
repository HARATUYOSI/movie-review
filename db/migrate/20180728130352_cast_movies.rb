class CastMovies < ActiveRecord::Migration[5.2]
  def change
    add_index :cast_movies, [:movie_id, :cast_id], :unique => true
  end
end
