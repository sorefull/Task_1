module Api
  class UsersController < ApplicationController
    before_action :authenticate!, only: :feed

    def show
      @user = User.find(params[:id])
      @posts = @user.posts
    end

    def feed
      @posts = Post.where(user_id: current_user.following)
    end

    def sign_in
       @user = User.find_by(name: params[:name])
       if @user
         render(json: @user.auth_token)
       else
         render(json: { error: 'Unauthorized!' })
       end
    end
  end
 end
