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
#

class User < ApplicationRecord
  # Registration autorization
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  has_secure_password
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
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # likes
  has_many :likes
  # too fat method
  def got_likes
    count = 0
    posts.each do |post|
      count += post.likes.count
    end
    count
  end

  def likes_this(post)
    likes.build(likable_id: post.id, likable_type: post.class.to_s)
    save
  end

  def unlikes_this(post)
    likes.where(likable_id: post.id, likable_type: post.class.to_s).first.destroy
    save
 end

end
