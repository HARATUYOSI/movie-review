class DirectorMovie < ApplicationRecord
  belongs_to :director
  belongs_to :movie
  validates :movie_id, uniqueness: { scope: :director_id }
end
