class MoviesController < ApplicationController
  before_action :access_admin, only: [:index, :new, :edit]
  def top
    topic = Movie.where(updated_at:1.weeks.ago..Time.now,week: 1..Float::INFINITY)
    @topic_1 = topic.sort{|f,s| s.week <=> f.week}.first(5)
    @now_1 = Movie.where("release_date <= ?", Time.now).where("release_end_date >= ?", Time.now).first(5)
    @coming_soon_1 = Movie.where(release_date: Time.now..Float::INFINITY).first(5)
    reviews = Review.last(6)
    @reviews = reviews.sort{|f,s| s.created_at <=> f.created_at}
  end
  def search
    @search = Movie.ransack(params[:q]) #ransackメソッド推奨
    @search_articles = @search.result.page(params[:page])
  end
  def topic
    topic = Movie.where(updated_at:1.weeks.ago..Time.now,week: 1..Float::INFINITY)
    @topic = topic.sort{|f,s| s.week <=> f.week}.first(30)
    @genre_id = Genre.first
    @country_id = Country.first
    @cast_id = Cast.first
    @director_id = Director.first
    @release_year_id = ReleaseYear.first
  end
  def now
    @now = Movie.where("release_date <= ?", Time.now).where("release_end_date >= ?", Time.now)

    @genre_id = Genre.first
    @country_id = Country.first
    @cast_id = Cast.first
    @director_id = Director.first
    @release_year_id = ReleaseYear.first
  end
  def coming
    @coming_soon = Movie.where(release_date: Time.now..Float::INFINITY)

    @genre_id = Genre.first
    @country_id = Country.first
    @cast_id = Cast.first
    @director_id = Director.first
    @release_year_id = ReleaseYear.first
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
  def access_admin
       unless   admin_signed_in?
         redirect_to root_path
       end
   end
	  def movie_params
	    params.require(:movie).permit(:title, :image, :release_date, :release_end_date, :genre_id, :country_id, :stroy, :release_year_id, :favorite_count, :review_count, :satr_average)
	  end

end
