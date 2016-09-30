Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, SocialSettings.facebook.key, SocialSettings.facebook.secret
  provider :twitter, SocialSettings.twitter.key, SocialSettings.twitter.secret,
    {
      :authorize_params => {
        :force_login => 'true'
      }
    }
end
