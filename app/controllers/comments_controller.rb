class CommentsController < ApplicationController
  def new
    @review = Review.find_by(id: params[:review_id])
    @comment = Comment.new
    @comments = Comment.where(review_id: params[:review_id])
    @like_users = Like.where(review_id:  params[:review_id])
  end
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.review_id = params[:review_id]
    if comment.save
      review = Review.find(params[:review_id])
      count = review.comment_count
      count += 1
      review.update(comment_count: count)
      redirect_to movie_path(params[:movie_id])
    end
  end
  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      review = Review.find(params[:review_id])
      count = review.comment_count
      count -= 1
      review.update(comment_count: count)
      redirect_to movie_path(params[:movie_id])
    end
  end
  private
	  def comment_params
	    params.require(:comment).permit(:comment, :spoiler, :review_id, :user_id)
	  end
end
