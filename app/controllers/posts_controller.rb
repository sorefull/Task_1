class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create, :destroy]
  before_action :if_cant_delete, only: :destroy
  before_action :if_blocked, only: [:new, :create, :destroy]

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

  def update
    respond_to do |format|
      if current_user.votes_this! @post, params[:meth]
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :created, location: @post }
        format.js { render :post }
      else
        format.html { render :new, alert: @post.errors }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
      redirect_to login_path, alert: 'Log in before!' unless logged_in?
    end

    def if_cant_delete
      unless ( current_user == @post.user ) or ( current_user.admin? )
        log_out
        redirect_to login_path, alert: 'Log in before!'
      end
    end

    def if_blocked
      redirect_to welcome_path, alert: 'Sorry, you are blocked!' if current_user.blocked?
    end
end
