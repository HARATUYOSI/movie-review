class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show

    @user = User.find(params[:id])
    @favorite_count = Favorite.where(user_id: params[:id]).count
    @review_count = Review.where(user_id: params[:id]).count
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
  private
  def user_params
      params.require(:user).permit(:name, :introduction, :email, :image)
  end
end
