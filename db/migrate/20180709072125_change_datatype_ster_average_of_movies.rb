class ChangeDatatypeSterAverageOfMovies < ActiveRecord::Migration[5.2]
  def change
    change_column :Movies, :satr_average, :integer, default: 0
  end
end
