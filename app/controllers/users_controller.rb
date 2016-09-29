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
      redirect_to signup_users_path, alert: @user.errors
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def follow
    user = User.find(params[:id])
    if current_user.following? user
      redirect_to user, alert: "You alredy follow #{user.name}!"
    elsif current_user == user
      redirect_to user, alert: "You can't follw yourself!"
    else
      current_user.follow user
      redirect_to user, notice: 'You followed sucessfully!'
    end
  end

  def unfollow
    user = User.find(params[:id])
    if !(current_user.following? user)
      redirect_to user, alert: "You didn't even started to follow #{user.name}!"
    elsif current_user == user
      redirect_to user, alert: "You can't unfollw yourself!"
    else
      current_user.unfollow user
      redirect_to user, notice: 'You unfollowed sucessfully!'
    end
  end

  def feed
    @posts = Post.where(user_id: current_user.following)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
