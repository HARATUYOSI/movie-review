class ChangeDatatypeStarAverageOfMovies < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :satr_average, :float, default: 0
  end
end
