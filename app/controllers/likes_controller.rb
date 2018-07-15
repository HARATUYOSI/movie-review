class LikesController < ApplicationController
  def create
    if Like.create(review_id: params[:review_id],user_id:current_user.id)
      review = Review.find_by(id: params[:review_id])
      count = review.like_count
      count += 1
      review.update(like_count: count)

      redirect_to movie_path(params[:movie_id])
    end
  end
  def destroy
    like = Like.find_by(review_id: params[:review_id], user_id: current_user.id)
    if like.destroy
      review = Review.find_by(id: params[:review_id])
      count = review.like_count
      count -= 1
      review.update(like_count: count)
    
      redirect_to movie_path(params[:movie_id])
    end
  end
end
