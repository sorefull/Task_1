class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :set_user, only: [:new, :create]
  before_action :owner?, only: :destroy
  before_action :can?, only: [:new, :create, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      # binding.pry
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, alert: @post.errors }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    if current_user.likes_this(@post)
      redirect_to @post, notice: 'You liked successfully!'
    else
      redirect_to @post, alert: 'You alredy liked!'
    end
  end

  def unlike
    if current_user.unlikes_this(@post)
      redirect_to @post, notice: 'You unliked successfully!'
    else
      redirect_to @post, alert: "You don't even likedliked!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def set_user
      unless logged_in?
        redirect_to login_path, alert: 'Log in before!'
      end
    end

    def owner?
      set_user
      unless ( current_user == @post.user ) or ( current_user.admin? )
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
