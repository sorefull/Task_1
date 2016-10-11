class UsersController < ApplicationController
  before_action :auth?, only: [:follow, :unfollow, :feed]
  before_action :set_user, only: [:show, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(name: user_params[:name], email: user_params[:email], password: user_params[:password], password_confirmation: user_params[:password_confirmation])
    if @user.save && @user.create_image(file: user_params[:avatar])
      log_in @user
      redirect_to @user
    else
      redirect_to signup_users_path, alert: @user.errors
    end
  end

  def show
  end

  # params[:relation] : [:follow, :unfollow]
  def update
    current_user.new_relation_with(@user, params[:relation])
    render partial: 'follow', locals: { user: @user }
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def auth?
    unless logged_in?
      redirect_to login_path, alert: 'Log in before!'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
