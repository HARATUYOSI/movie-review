class CreateReleaseYears < ActiveRecord::Migration[5.2]
  def change
    create_table :release_years do |t|
      t.integer :year

      t.timestamps
    end
  end
end
