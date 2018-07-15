class CastsController < ApplicationController
  def new
    @cast = Cast.new
    @casts = Cast.all
    @cast_movies = CastMovie.where(movie_id: params[:movie_id])
  end
  def create
    if cast= Cast.find_by(name: params[:cast][:name])
       a = CastMovie.create(cast_id: cast.id, movie_id: params[:movie_id])
       redirect_to new_movie_cast_path(params[:movie_id])
    else
       new_cast = Cast.create(name: params[:cast][:name])
       CastMovie.create(cast_id: new_cast.id, movie_id: params[:movie_id])
       redirect_to new_movie_cast_path(params[:movie_id])
    end
  end
  def show
    @cast = Cast.find_by(id: params[:id])
    @casts = Cast.all
    @movies = CastMovie.where(cast_id: params[:id])
  end
end
