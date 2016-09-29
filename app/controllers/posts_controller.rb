class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create]
  before_action :owner?, only: :destroy
  before_action :can?, only: [:new, :create, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, alert: @post.errors }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def set_user
      unless logged_in?
        redirect_to login_path, alert: 'Log in before!'
      end
    end

    def owner?
      unless current_user == @post.user
        log_out
        redirect_to login_path, alert: 'Log in before!'
      end
    end

    def can?
      if current_user.blocked?
        redirect_to welcome_path, alert: 'Sorry, you are blocked!'
      end
    end
end
