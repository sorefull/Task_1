module Admin
  class UsersController < ApplicationController
    before_action :set_admin
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.all
    end

    def edit
    end

    def update
      unless @user == current_user
        @user.update!(user_params)
        redirect_to admin_users_path, notice: "You edited #{@user.name}'s account."
      else
        redirect_to admin_users_path, alert: "You can't edit your account!"
      end
    end

    def destroy
      unless @user == current_user
        name = @user.name
        @user.destroy
        FileUtils.rm_rf("public/uploads/user/avatar/#{params[:id]}")
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

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:role, :status)
    end
  end
end
