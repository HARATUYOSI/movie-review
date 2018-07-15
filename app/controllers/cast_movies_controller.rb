class CastMoviesController < ApplicationController
  def destroy
    cast_movie = CastMovie.find_by(id: params[:id])
    if cast_movie.destroy
       redirect_to new_movie_cast_path(params[:movie_id])
    end
  end
end
