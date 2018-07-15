class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :movie_id
      t.integer :user_id
      t.boolean :best_movie, default: false

      t.timestamps
    end
  end
end
