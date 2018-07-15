class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :review_id
      t.string :comment
      t.boolean :spoiler, default: false

      t.timestamps
    end
  end
end
