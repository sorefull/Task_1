class SessionsController < ApplicationController
  before_action :set_user, only: :create_social

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      # redirect_to user
      log_in user
      redirect_to user, notice: 'You loged in'
    else
      # Create an error message.
      redirect_to login_path, alert: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to welcome_path, notice: 'You loged out'
  end

  def create_social
    @user.update(name: auth_hash['info']['name'],
                password: SecureRandom.urlsafe_base64)
    if auth_hash['provider'] == "facebook"
      @user.update(email: auth_hash['info']['email'])
    elsif auth_hash['provider'] == "twitter"
      @user.update(email: Faker::Internet.email)
    end
    log_in(@user)
    redirect_to welcome_path
  end

  private

  def set_user
    @user = User.find_or_initialize_by(provider: auth_hash['provider'], provider_id: auth_hash['uid'])
  end

  def auth_hash
   request.env['omniauth.auth']
  end
end
