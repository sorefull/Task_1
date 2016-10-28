class CommentsController < ApplicationController
  before_action :if_logged_in
  before_action :set_post
  before_action :set_comment, only: [:destroy, :update, :edit]
  before_action :if_cant_delete, only: :destroy


  def create
    @post.commented_by(current_user, comment_params[:body])
    render partial: 'comments', locals: { collection: @post }
  end

  def destroy
    @comment.destroy
    render partial: 'comments', locals: { collection: @post }
  end

  def update
    if params[:meth]
      @comment.vote current_user, params[:meth]
    else
      @comment.update(comment_params)
    end
    render partial: 'comments', locals: { collection: @post }
  end

  def edit
    render partial: 'form', locals: { collection: [@comment, @post] }
  end

  private
  def if_logged_in
    redirect_to login_path, alert: 'You mast be logged in!' unless logged_in?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id]) if params[:post_id]
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def if_cant_delete
    unless ( current_user == @post.comments.find(params[:id]).user ) or ( current_user.admin? )
      log_out
      redirect_to login_path, alert: 'Log in before!'
    end
  end
end
