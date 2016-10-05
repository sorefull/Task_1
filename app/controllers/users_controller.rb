class UsersController < ApplicationController
  before_action :auth?, only: [:follow, :unfollow, :feed]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      redirect_to signup_users_path, alert: @user.errors
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    user = User.find(params[:id])
    message = current_user.follow user
    redirect_to user, notice: message
  end

  def unfollow
    user = User.find(params[:id])
    message = current_user.unfollow user
    redirect_to user, notice: message
  end

  def update
    binding.pry
    user = User.find(params[:id])
    if params[:to] == 'follow'
      message = current_user.follow user
    elsif params[:to] == 'unfollow'
      message = current_user.unfollow user
    end
    redirect_to user, notice: message
  end

  def feed
    @posts = Post.where(user_id: current_user.following)
  end

  private
  def auth?
    unless logged_in?
      redirect_to login_path, alert: 'Log in before!'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
