class ChangeDatatypeSpoilerOfReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :spoiler, :boolean, default: false
  end
end
