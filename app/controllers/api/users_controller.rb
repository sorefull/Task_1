module Api
  class UsersController < ApplicationController
    before_action :authenticate!, only: :feed

    def show
      @user = User.find(params[:id])
      @posts = @user.posts
    end

    def feed
      if current_user
        @posts = Post.where(user_id: current_user.following)
      else
        render(json: { error: "Unauthorized."} , status: 401)
      end 
    end

    def sign_in
       @user = User.find_by(name: params[:name])
       if @user && @user.authenticate(params[:password])
         render(json: { auth_token: @user.auth_token,
           instruction: "Now you can use your auth_token to get feed#{ ' and admin page' if @user.admin? }." })
       else
         render(json: { error: "Unauthorized."} , status: 401)
       end
    end
  end
 end
