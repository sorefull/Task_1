class SocialSettings < Settingslogic
  source "#{Rails.root}/config/social.yml"
  namespace Rails.env
end
