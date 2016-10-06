# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  role            :integer          default("user")
#  status          :integer          default("normal")
#  provider        :string
#  provider_id     :string
#  auth_token      :string
#

class User < ApplicationRecord
  # Registration autorization
  before_save { self.email = email.downcase  }
  before_create :set_auth_token
  validates :name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :auth_token, uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }

  # Posts
  has_many :posts, dependent: :destroy

  #admin
  enum role: [:user, :admin] #[:moderator, :owner, etc]

  # blocked
  enum status: [:normal, :blocked]

  # folowing
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  # Follows a user.
  def follow(other_user)
    if self.following? other_user
      false
    elsif self == other_user
      false
    else
      active_relationships.create(followed_id: other_user.id)
      true
    end
  end

  # Unfollows a user.
  def unfollow(other_user)
    if !(self.following? other_user)
      false
    elsif self == other_user
      false
    else
      active_relationships.find_by(followed_id: other_user.id).destroy
      true
    end
  end

  def set_this_user_to(user, new_relation) # new_relation: [:follow, :unfollow]
    case new_relation
    when 'follow'
      self.follow user
    when 'unfollow'
      self.unfollow user
    else
      false
    end
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # votes
  # Votes polymrphic, so I keep likes_this! and so on here, in User model to DRY in future.
  has_many :votes, dependent: :destroy

  def votes_this!(resource, vote) # vote: [:up, :down], resource: [:post]
    unless voted? resource
      self.votes.build(votable_id: resource.id, votable_type: resource.class.to_s, vote: vote)
      save
    else
      false
    end
  end

  def unvotes_this!(resource)
    if voted? resource
      votes.where(votable_id: resource.id, votable_type: resource.class.to_s).first.destroy
      save
    else
      false
    end
  end

  def voted?(resource)
    return votes.where(votable_id: resource.id, votable_type: resource.class.to_s).first.present?
  end

  # APIs
  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    unicuetoken = SecureRandom.uuid.gsub(/\-/,'')
    generate_auth_token if User.find_by(auth_token: unicuetoken)
    unicuetoken
  end

end
