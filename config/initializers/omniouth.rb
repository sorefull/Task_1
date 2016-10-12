Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, SocialSettings.facebook.key, SocialSettings.facebook.secret, image_size: 'large'
  provider :twitter, SocialSettings.twitter.key, SocialSettings.twitter.secret,
    {
      :authorize_params => {
        :force_login => 'true'
      }
    }
end
