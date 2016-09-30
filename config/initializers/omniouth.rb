Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FacebookSettings.facebook.key, FacebookSettings.facebook.secret
end
