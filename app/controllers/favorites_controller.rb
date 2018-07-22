class FavoritesController < ApplicationController
  def create
    if Favorite.create(movie_id: params[:movie_id],user_id: current_user.id)
      movie = Movie.find(params[:movie_id])
      count = movie.favorite_count
      count += 1
      review_week = Review.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
      favorite_week = Favorite.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
      week_count = review_week.length + favorite_week.length
      movie.update(favorite_count: count,week: week_count)
      redirect_to movie_path(params[:movie_id])
    end
  end
  def destroy
    favorite = Favorite.find_by(movie_id: params[:movie_id],user_id: current_user.id)
    if favorite.destroy
      movie = Movie.find(params[:movie_id])
      count = movie.favorite_count
      count -= 1
      review_week = Review.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
      favorite_week = Favorite.where(movie_id: params[:movie_id],created_at:1.weeks.ago..Time.now)
      week_count = review_week.length + favorite_week.length
      movie.update(favorite_count: count,week: week_count)
      redirect_to movie_path(params[:movie_id])
    end
  end
  def best_movie
    favorite = Favorite.find_by(movie_id: params[:id],user_id: current_user.id)
    if favorite.update(best_movie: true)

      redirect_to "/users/#{current_user.id}/favorites"
    end
  end
  def best_movie_delete
    favorite = Favorite.find_by(movie_id: params[:id],user_id: current_user.id)
    if favorite.update(best_movie: false)
      redirect_to "/users/#{current_user.id}/favorites"
    end
  end
end
