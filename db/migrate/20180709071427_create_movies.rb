class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :image_id
      t.date :release_date
      t.date :release_end_date
      t.integer :genre_id
      t.integer :country_id
      t.text :stroy
      t.integer :release_year_id
      t.integer :favorite_count, default: 0
      t.integer :review_count, default: 0
      t.string :satr_average, default: 0

      t.timestamps
    end
  end
end
