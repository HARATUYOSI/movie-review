class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @favorite_count = Favorite.where(user_id: params[:id]).count
    @review_count = Review.where(user_id: params[:id]).count
    followings = Relationship.where(follower_id: params[:id])
    user_id = followings.pluck(:following_id)
    favorites_1 = Favorite.where(user_id: user_id)
    reviews = Review.where(user_id: user_id)
    b = reviews+favorites_1
    @time_line= b.sort{|f,s| s.created_at <=> f.created_at}
  end
  def favorites
    @user = User.find(params[:id])
    @favorite_count = Favorite.where(user_id: params[:id]).count
    @review_count = Review.where(user_id: params[:id]).count
    @movies = Favorite.where(user_id: params[:id])
    @best_movies = Favorite.where(user_id: params[:id],best_movie: true)
     @best_movie_count = Favorite.where(best_movie: true,user_id: params[:id]).count
  end
  def reviews
    @user = User.find(params[:id])
    @favorite_count = Favorite.where(user_id: params[:id]).count
    @review_count = Review.where(user_id: params[:id]).count
    @reviews = Review.where(user_id: params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update

    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザ情報を編集しました"
      redirect_to user_path(@user.id)
    else
       render root_path
    end
  end
  def following
      @favorite_count = Favorite.where(user_id: params[:id]).count
      @review_count = Review.where(user_id: params[:id]).count
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @favorite_count = Favorite.where(user_id: params[:id]).count
    @review_count = Review.where(user_id: params[:id]).count
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
  private
  def user_params
      params.require(:user).permit(:name, :introduction, :email, :image)
  end
end
