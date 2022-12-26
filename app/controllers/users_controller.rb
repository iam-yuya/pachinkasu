class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_nomal_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def index
    @users = User.all
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_nomal_user
    if current_user.email == 'guest@example.com'
      redirect_to request.referer, notice: 'ゲストユーザーの更新・削除はできません。'
    end
  end

end
