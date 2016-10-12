module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def admin_logged_in?
    current_user.admin? if logged_in?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def social_update(user)
    user.update(name: auth_hash['info']['name'], password: SecureRandom.urlsafe_base64)
    if auth_hash['provider'] == "facebook"
      user.update(email: auth_hash['info']['email'])
      user.create_image(remote_file_url: auth_hash.info.image.gsub('http://','https://'))
    elsif auth_hash['provider'] == "twitter"
      user.update(email: Faker::Internet.email)
      user.create_image(remote_file_url: auth_hash.info.image.sub("_normal", ""))
    end
    user.set_auth_token
  end
end
