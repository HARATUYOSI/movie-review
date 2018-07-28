class Director < ApplicationRecord
  has_many :movies, through: :director_movies
  has_many :director_movis
  validates :name, presence: true
end
