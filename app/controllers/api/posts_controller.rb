module Api
  class PostsController < ApplicationController

    def index
      @posts = Post.all
    end

    def show
      set_post
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

  end
end
