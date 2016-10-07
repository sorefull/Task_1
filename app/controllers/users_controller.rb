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

  # params[:relation] : [:follow, :unfollow]
  def update
    user = User.find(params[:id])
    current_user.new_relation_with(user, params[:relation])
    redirect_to user
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
