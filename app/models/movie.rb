class Movie < ApplicationRecord
  belongs_to :genre
  belongs_to :country
  belongs_to :release_year
  has_many :casts, through: :cast_movies
  has_many :cast_movies, :dependent => :destroy
  has_many :directors, through: :director_movies
  has_many :director_movies, :dependent => :destroy
  has_many :users, through: :favorites
  has_many :favorites, :dependent => :destroy
  has_many :users, through: :reviews
  has_many :reviews, :dependent => :destroy
  attachment :image
  def favorited_movie_by?(user,movie)
    favorites.where(user_id: user.id,movie_id: movie.id).exists?
  end

end
