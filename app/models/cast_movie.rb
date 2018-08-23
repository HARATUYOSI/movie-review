class CastMovie < ApplicationRecord
  belongs_to :cast
  belongs_to :movie
  validates :cast_id, uniqueness: { scope: :movie_id }
end
