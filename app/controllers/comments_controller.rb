class CommentsController < ApplicationController
  before_action :if_logged_in
  before_action :set_resource
  before_action :set_comment, only: [:destroy, :update]
  before_action :if_cant_delete, only: :destroy


  def create
    @resource.commented_by!(current_user, comment_params[:body])
    render partial: 'comments', locals: { resource: @resource }
  end

  def destroy
    @comment.destroy
    render partial: 'comments', locals: { resource: @resource }
  end

  def update
    if current_user.votes_this! @comment, params[:meth]
      render partial: 'comments', locals: { resource: @resource }
    end
  end

  private
  def if_logged_in
    redirect_to login_path, alert: 'You mast be logged in!' unless logged_in?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_resource
    @resource = Post.find(params[:post_id]) if params[:post_id]
  end

  def set_comment
    @comment = @resource.comments.find(params[:id])
  end

  def if_cant_delete
    unless ( current_user == @resource.comments.find(params[:id]).user ) or ( current_user.admin? )
      log_out
      redirect_to login_path, alert: 'Log in before!'
    end
  end
end
