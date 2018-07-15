class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :movie_id
      t.integer :User_id
      t.text :review
      t.integer :star, default: 0
      t.boolean :spoiler, null: false
      t.integer :like_count, default: 0
      t.integer :comment_count, default: 0

      t.timestamps
    end
  end
end
