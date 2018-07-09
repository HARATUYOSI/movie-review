class Movie < ApplicationRecord
  belongs_to :genre
  belongs_to :country
  belongs_to :release_year
  has_many :casts, through: :cast_movies
  has_many :cast_movis
  accepts_nested_attributes_for :cast_movis
  has_many :directors, through: :director_movies
  has_many :director_movis
  accepts_nested_attributes_for :director_movis
  attachment :image
end
