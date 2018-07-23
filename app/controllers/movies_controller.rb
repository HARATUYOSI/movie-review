class MoviesController < ApplicationController
  def top
    @movies = Movie.all
    reviews = Review.last(6)
    @reviews = reviews.sort{|f,s| s.created_at <=> f.created_at}
  end
  def new
    @casts = Cast.all
    @directors = Director.all
    @genres = Genre.all
    @countries = Country.all
    @release_years = ReleaseYear.all
    @movie = Movie.new
    @cast = Cast.new
    @director = Director.new
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

      redirect_to new_movie_cast_path(@movie.id)
    end
  end
  def edit
    @movie = Movie.find(params[:id])

    @genre = Genre.find(@movie.genre_id)
    @country = Country.find(@movie.country_id)
    @release_year = ReleaseYear.find(@movie.release_year_id)
    @casts = Cast.all
    @directors = Director.all
    @genres = Genre.all
    @countries = Country.all
    @release_years = ReleaseYear.all
  end
  def update
    @movie = Movie.find(params[:id])

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
    if @movie.update(movie_params)

      redirect_to new_movie_cast_path(@movie.id)
    end
  end
  def destroy
    movie = Movie.find(params[:id])
    if movie.destroy
      redirect_to movies_path
    end
  end
  def index
    @movies = Movie.all
  end
  def link
    @genres = Genre.all
    @release_years = ReleaseYear.all
    @casts = Cast.all
    @directors = Director.all
    @countries = Country.all
  end
  def show
    @movie = Movie.find(params[:id])
    @directors = DirectorMovie.where(movie_id: params[:id])
    @casts = CastMovie.where(movie_id: params[:id])
    if user_signed_in?
     @review = Review.find_by(movie_id: params[:id],user_id: current_user.id)
   end
     reviews = Review.where(movie_id: params[:id])
     ids = reviews.pluck(:user_id)
     if @review

     ids.delete(@review.user_id)
   end
     @reviews = Review.where(movie_id: params[:id], user_id: ids)
  end

  private
	  def movie_params
	    params.require(:movie).permit(:title, :image, :release_date, :release_end_date, :genre_id, :country_id, :stroy, :release_year_id, :favorite_count, :review_count, :satr_average)
	  end
end
