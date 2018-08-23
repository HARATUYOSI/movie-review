class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search, :notification

  def set_search
    @search = Movie.ransack(params[:q])
    @search_articles = @search.result.page(params[:page])
  end
  def notification
    if user_signed_in?
      users = Relationship.where(follower_id: current_user.id).limit(10).order("created_at DESC")
      reviews_id = Review.where(user_id: current_user.id).order("created_at DESC").pluck(:id)
      comments = Comment.where(review_id: reviews_id).limit(10).order("created_at DESC")
      likes = Like.where(review_id: reviews_id).limit(10).order("created_at DESC")
      notifications = users + comments + likes
      @notifications = notifications.sort{|f,s| s.created_at <=> f.created_at}.first(10)
    end
  end
  protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :image, :follower_count, :follwing_count])
 end
end
