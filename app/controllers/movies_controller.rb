class MoviesController < ApplicationController
  def top
  end
  def new
    @genres = Genre.all
    @countries = Country.all
    @release_years = ReleaseYear.all
    @movie = Movie.new
    @genre = Genre.new
    @country = Country.new
    @release_year = ReleaseYear.new
  end
  def create
    @movie = Movie.new(movie_params)
    if genre = Genre.find_by(name: params[:genre][:name])
	     @movie.genre_id = genre.id
	  else
	    　new_genre = Genre.create(name: params[:genre][:name])
	  　　@movie.genre_id = new_genre.id
	  end
    if country = Country.find_by(name: params[:country][:name])
	     @movie.country_id = country.id
	  else
	    　new_country = Country.create(name: params[:country][:name])
	  　　@movie.country_id = new_country.id
	  end
    if release_year= ReleaseYear.find_by(year: params[:release_year][:year])
	     @movie.release_year_id = release_year.id
	  else
	    　new_release_year = ReleaseYear.create(year: params[:release_year][:year])
	  　　@movie.release_year_id = new_release_year.id
	  end
    if @movie.save
      redirect_to root_path
    end
  end
  def edit
  end
  def update
  end
  def destroy
  end
  def index
  end
  def link
  end
  private
	  def movie_params
	    params.require(:movie).permit(:title, :image, :release_date, :release_end_date, :genre_id, :country_id, :stroy, :release_year_id, :favorite_count, :review_count, :satr_average)
	  end
end
