module Registrable
  extend ActiveSupport::Concern

  included do
    before_save { self.email = email.downcase  }
    before_create :set_auth_token
    validates :name, presence: true, length: { maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence:   true, length: { maximum: 255 },
                      format:     { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :auth_token, uniqueness: true
  end

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    unicuetoken = SecureRandom.uuid.gsub(/\-/,'')
    generate_auth_token if self.class.find_by(auth_token: unicuetoken)
    unicuetoken
  end
end
