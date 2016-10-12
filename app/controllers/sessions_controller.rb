class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user, notice: 'You loged in'
    else
      redirect_to login_path, alert: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to welcome_path, notice: 'You loged out'
  end

  def create_social
    user = User.find_or_initialize_by(provider: auth_hash['provider'], provider_id: auth_hash['uid'])
    binding.pry
    if user
      social_update user
      log_in user
      redirect_to welcome_path, notice: 'You loged in'
    else
      redirect_to welcome_path, alert: 'Invalid'
    end
  end

  private
  def auth_hash
   request.env['omniauth.auth']
  end
end
