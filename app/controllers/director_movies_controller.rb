class DirectorMoviesController < ApplicationController
  def destroy
    director_movie = DirectorMovie.find_by(id: params[:id])
    if director_movie.destroy
       redirect_to new_movie_director_path(params[:movie_id])
    end
  end
end
