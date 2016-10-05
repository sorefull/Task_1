module Admin
  class UsersController < ApplicationController
    before_action :set_admin

    def index
      @users = User.all
    end

    def update
      @user = User.find(params[:id])
      unless @user == current_user
        @user.update!(user_params)
        redirect_to admin_users_path, notice: "You edited #{@user.name}'s account."
      else
        redirect_to admin_users_path, alert: "You can't edit your account!"
      end
    end

    def destroy
      @user = User.find(params[:id])
      unless @user == current_user
        name = @user.name
        @user.destroy
        redirect_to admin_users_path, alert: "You sucessfully deleted user '#{name}'"
      else
        redirect_to admin_users_path, alert: "You can't delete yourself!"
      end
    end

    private
    def set_admin
      unless admin_logged_in?
        log_out
        redirect_to login_path, alert: 'You mast be Admin!'
      end
    end

    def user_params
      params.require(:user).permit(:role, :status)
    end
  end
end
