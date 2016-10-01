module Api
  class AdminsController < ApplicationController
    # before_action :set_admin
    before_action :authenticate_admin!

    def index
      @users = User.all
    end
    
  end
end
