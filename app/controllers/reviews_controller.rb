class ReviewsController < ApplicationController

  before_action :access_admin, only: [:index]

  def index
    @reviews = Review.all
  end
  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
    @my_review = Review.where(user_id: current_user.id,movie_id: params[:movie_id])
  end
  def create
    movie = Movie.find_by(id: params[:movie_id])
    review = Review.new(review_params)
    review.movie_id = params[:movie_id]
    review.user_id = current_user.id
    review.star = params[:star]
    if review.save
      movie = Movie.find(params[:movie_id])
      count = movie.review_count
      count += 1
      if movie.update(review_count: count)
         reviews= Review.where(movie_id: params[:movie_id])
         star = reviews.pluck(:star).sum / reviews.count.to_f
         star = star.round(1)
         review_week = Review.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
         favorite_week = Favorite.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
         week_count = review_week.length + favorite_week.length
         movie.update(satr_average: star, week: week_count)
         redirect_to movie_path(params[:movie_id])
      else
         render 'new'
      end
    end
  end
  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @my_review = Review.where(user_id: current_user.id,movie_id: params[:movie_id])
  end
  def update
    movie = Movie.find_by(id: params[:movie_id])
    review = Review.find(params[:id])
    review.star = params[:star]
    if review.update(review_params)
       reviews= Review.where(movie_id: params[:movie_id])
       star = reviews.pluck(:star).sum / reviews.count.to_f
       star = star.round(1)
       movie.update(satr_average: star)
       redirect_to movie_path(params[:movie_id])
    end
  end
  def destroy
    review = Review.find_by(id: params[:id])
    if review.destroy
      movie = Movie.find_by(id: params[:movie_id])
      count = movie.review_count
      count -=1
      movie.update(review_count: count)
      reviews= Review.where(movie_id: params[:movie_id])
      if reviews.count == 0
        star = 0
      else
        star = reviews.pluck(:star).sum / reviews.count
        star = star.round(1)
        review_week = Review.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
        favorite_week = Favorite.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
        week_count = review_week.length + favorite_week.length
        movie.update(satr_average: star, week: week_count)
      end
        redirect_to movie_path(params[:movie_id])
    end
  end
  private
	def review_params
	params.require(:review).permit(:user_id,:movie_id,:review,:star,:spoiler, :comment_count)
	end

  def access_admin
       unless   admin_signed_in?
         redirect_to root_path
       end
   end
end
