class AdminsController < ApplicationController
  before_action :set_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    unless @user == current_user
      name = @user.name
      @user.destroy_user
      redirect_to users_path, alert: "You sucessfully deleted user '#{name}'"
    else
      redirect_to users_path, alert: "You can't delete yourself!"
    end
  end

  def chenge_role
    @user = User.find(params[:id])
    unless @user == current_user
      if @user.admin?
        @user.user!
      else
        @user.admin!
      end
      redirect_to users_path, notice: "You chenged #{@user.name}'s role to #{@user.role}."
    else
      redirect_to users_path, alert: "You can't chenge your role!"
    end
  end

  def chenge_status
    @user = User.find(params[:id])
    unless @user == current_user
      if @user.blocked?
        @user.normal!
      else
        @user.blocked!
      end
      redirect_to users_path, notice: "You chenged #{@user.name}'s status to #{@user.status}."
    else
      redirect_to users_path, alert: "You can't chenge your status!"
    end
  end

  private
  def set_admin
    unless admin_logged_in?
      log_out
      redirect_to login_path, alert: 'You mast be Admin!'
    end
  end
end
