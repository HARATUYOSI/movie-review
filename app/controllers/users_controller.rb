class UsersController < ApplicationController
  def index
  end
  def show
    @user = User.find(params[:id])
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
