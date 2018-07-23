class ReviewsController < ApplicationController
  def new
    @review = Review.new
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
    end
  end
  end
  def edit
    @review = Review.find(params[:id])

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
    review = Review.find_by(movie_id: params[:movie_id],user_id: current_user.id)

    if review.destroy
      movie = Movie.find_by(id: params[:movie_id])
      count = movie.review_count
      count -=1
      movie.update(review_count: count)
      reviews= Review.where(movie_id: params[:movie_id])
        star = reviews.pluck(:star).sum / reviews.count.to_f
        star = star.round(1)
        review_week = Review.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
        favorite_week = Favorite.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
        week_count = review_week.length + favorite_week.length
      movie.update(satr_average: star, week: week_count)
      redirect_to movie_path(params[:movie_id])
    end
  end
  private
	def review_params
	params.require(:review).permit(:user_id,:movie_id,:review,:star,:spoiler)
	end
end
