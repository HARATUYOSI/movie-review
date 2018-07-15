class GenresController < ApplicationController
  def show
    @genre = Genre.find_by(id: params[:id])
    @genres = Genre.all
    @movies = Movie.where(genre_id: params[:id])
  end
end
