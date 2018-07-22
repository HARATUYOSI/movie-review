class AddWeekToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :week, :integer, default: 0
  end
end
