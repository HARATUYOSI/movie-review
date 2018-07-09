class CreateCastMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :cast_movies do |t|
      t.integer :cast_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
