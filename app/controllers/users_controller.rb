class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      redirect_to signup_path, alert: @user.errors
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def subscribe
    user = User.find(params[:id])
    if !logged_in?
      redirect_to login_path, alert: "Login before!"
    elsif current_user == user
      redirect_to user_path(user), alert: "You can't subscribe yourself!"
    elsif current_user.subscribe! user
      redirect_to user_path(user), notice: "You subscribed #{user.name} sucessfully!"
    else
      redirect_to user_path(user), alert: "You alredy subscribe #{user.name}!"
    end
  end

  def unsubscribe
    user = User.find(params[:id])
    if !logged_in?
      redirect_to login_path, alert: "Login before!"
    elsif current_user == user
      redirect_to user_path(user), alert: "You can't unsubscribe yourself!"
    elsif current_user.unsubscribe! user
      redirect_to user_path(user), alert: "You unsubscribed #{user.name} sucessfully!"
    else
      redirect_to user_path(user), alert: "You don't even start subscribing #{user.name}!"
    end
  end

  def news
    if logged_in?
      @posts = Post.where(user_id: current_user&.subscribers)
    else
      redirect_to login_path, alert: 'You need to log in!'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
