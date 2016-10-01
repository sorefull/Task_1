module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token

    def current_user
      @user ||= User.find_by(auth_token: params[:auth_token])
    end

    def authenticate!
      render(json: { error: 'Unauthorized!' }) if current_user.blank?
    end

    def authenticate_admin!
      render(json: { error: 'Unauthorized!' }) unless current_user.admin?
    end
  end
end
