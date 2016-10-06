class FeedsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.following)
  end
end
