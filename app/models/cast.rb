class Cast < ApplicationRecord
  has_many :movies, through: :cast_movies
  has_many :cast_movis
end
