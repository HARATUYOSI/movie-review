class DirectorsController < ApplicationController
  before_action :access_admin, only: [:new]
  def new
    @director = Director.new
    @directors = Director.all

    @director_movies = DirectorMovie.where(movie_id: params[:movie_id])
  end
  def create
    if director= Director.find_by(name: params[:director][:name])
       DirectorMovie.create(director_id: director.id, movie_id: params[:movie_id])
       redirect_to new_movie_director_path(params[:movie_id])
    else
       new_director = Director.create(name: params[:director][:name])
       DirectorMovie.create(director_id: new_director.id, movie_id: params[:movie_id])
       redirect_to new_movie_director_path(params[:movie_id])

    end
  end
  def show
    @director = Director.find_by(id: params[:id])
    @directors = Director.all
    @movies = DirectorMovie.where(director_id: params[:id])
  end
  private
  def access_admin
       unless   admin_signed_in?
         redirect_to root_path
       end
   end
end
