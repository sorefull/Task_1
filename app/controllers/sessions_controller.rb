class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      # redirect_to user
      log_in user
      redirect_to user, notice: :succesfully
    else
      # Create an error message.
      redirect_to login_path, alert: 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to welcome_path
  end
end
