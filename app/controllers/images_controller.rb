class ImagesController < ApplicationController
  before_action :set_resource
  before_action :if_exist

  def show
  end

  def update
    if @resource.image.vote current_user, params[:meth]
      render partial: 'votes', locals: { resource: @resource }
    end
  end

  private
  def set_resource
    @resource = Post.find(params[:post_id]) if params[:post_id]
    @resource = User.find(params[:user_id]) if params[:user_id]

  end

  def if_exist
    redirect_to @resource unless @resource.image.present?
  end
end
